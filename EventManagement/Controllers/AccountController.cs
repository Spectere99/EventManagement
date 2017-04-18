using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using System.Web;
using System.Web.Configuration;
using System.Web.Mvc;
using System.Web.Security;
using Common;
using Common.Reader;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using EventManagement.Models;

namespace EventManagement.Controllers
{
    [Authorize]
    public class AccountController : ApplicationBaseController
    {
        private ApplicationSignInManager _signInManager;
        private ApplicationUserManager _userManager;
        private ApplicationDbContext _context;

        private string _SmtpServer;
        private string _SmtpAuthAccount;
        private string _SmtpAuthPassword = "";
        private string _outputEmail;
        private string[] _ccEmails;


        public AccountController()
        {
            _context = new ApplicationDbContext();   
        }

        public AccountController(ApplicationUserManager userManager, ApplicationSignInManager signInManager)
        {
            UserManager = userManager;
            SignInManager = signInManager;
        }

        public ApplicationSignInManager SignInManager
        {
            get
            {
                return _signInManager ?? HttpContext.GetOwinContext().Get<ApplicationSignInManager>();
            }
            private set
            {
                _signInManager = value;
            }
        }

        public ApplicationUserManager UserManager
        {
            get
            {
                return _userManager ?? HttpContext.GetOwinContext().GetUserManager<ApplicationUserManager>();
            }
            private set
            {
                _userManager = value;
            }
        }

        // The Authorize Action is the end point which gets called when you access any
        // protected Web API. If the user is not logged in then they will be redirected to 
        // the Login page. After a successful login you can call a Web API.
        [HttpGet]
        public ActionResult Authorize()
        {
            var claims = new ClaimsPrincipal(User).Claims.ToArray();
            var identity = new ClaimsIdentity(claims, "Bearer");
            AuthenticationManager.SignIn(identity);
            return new EmptyResult();
        }

        //
        // GET: /Account/Login
        [AllowAnonymous]
        public ActionResult Login(string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            return View();
        }

        //
        // POST: /Account/Login
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Login(LoginViewModel model, string returnUrl)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }

            var user = await UserManager.FindByNameAsync(model.UserName);
            //if (user != null)
            //{
            //    if (!await UserManager.IsEmailConfirmedAsync(user.Id))
            //    {
            //        ModelState.AddModelError("", "You need to confirm your email");
            //        model.EmailConfirmed = false;
            //        return View(model);
            //    }
            //}
            // This doesn't count login failures towards account lockout
            // To enable password failures to trigger account lockout, change to shouldLockout: true
            var result = await SignInManager.PasswordSignInAsync(model.UserName, model.Password, model.RememberMe, shouldLockout: false);

            FormsAuthentication.SetAuthCookie(model.UserName, model.RememberMe);
            Session["MyMenu"] = null;

            switch (result)
            {
                case SignInStatus.Success:
                    return RedirectToLocal(returnUrl);
                case SignInStatus.LockedOut:
                    return View("Lockout");
                case SignInStatus.RequiresVerification:
                    return RedirectToAction("SendCode", new { ReturnUrl = returnUrl, RememberMe = model.RememberMe });
                case SignInStatus.Failure:
                default:
                    ModelState.AddModelError("", "Invalid login attempt.");
                    return View(model);
            }
        }

        [AllowAnonymous]
        public ActionResult ResendValidationCode(string id)
        {
            var user = UserManager.FindByName(id);
            string confirmCode = UserManager.GenerateEmailConfirmationToken(user.Id);
            SendValidationCodeEmail(user, user.UserName, confirmCode);

            return RedirectToAction("RegistrationComplete", "Account", new { userId = user.Id, code = confirmCode });
        }
        //
        // GET: /Account/VerifyCode
        [AllowAnonymous]
        public async Task<ActionResult> VerifyCode(string provider, string returnUrl, bool rememberMe)
        {
            // Require that the user has already logged in via username/password or external login
            if (!await SignInManager.HasBeenVerifiedAsync())
            {
                return View("Error");
            }
            return View(new VerifyCodeViewModel { Provider = provider, ReturnUrl = returnUrl, RememberMe = rememberMe });
        }

        //
        // POST: /Account/VerifyCode
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> VerifyCode(VerifyCodeViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }

            // The following code protects for brute force attacks against the two factor codes. 
            // If a user enters incorrect codes for a specified amount of time then the user account 
            // will be locked out for a specified amount of time. 
            // You can configure the account lockout settings in IdentityConfig
            var result = await SignInManager.TwoFactorSignInAsync(model.Provider, model.Code, isPersistent: model.RememberMe, rememberBrowser: model.RememberBrowser);
            switch (result)
            {
                case SignInStatus.Success:
                    return RedirectToLocal(model.ReturnUrl);
                case SignInStatus.LockedOut:
                    return View("Lockout");
                case SignInStatus.Failure:
                default:
                    ModelState.AddModelError("", "Invalid code.");
                    return View(model);
            }
        }

       
        // GET: /Account/Register
        [AllowAnonymous]
        public ActionResult Register(string returnUrl)
        {
            //Set State List
            try
            {
                Session["EventStartPage"] = returnUrl;
                PersonTypeReader personTypeReader = new PersonTypeReader();
                UnitTypeReader unitTypeReader = new UnitTypeReader();
                UnitReader unitReader = new UnitReader();

                var personTypes = personTypeReader.GetList().Where(p => p.PersonTypeId > 0).ToList();
                var unitTypes = unitTypeReader.GetList().Where(p => p.UnitTypeId > 0).ToList();
                var units = unitReader.GetList().Where(p => p.UnitType.UnitTypeId == unitTypes[0].UnitTypeId).ToList();
                RegisterViewModel registerViewModel = new RegisterViewModel()
                {
                    StateList = Utilities.States,
                    PersonTypeList = personTypes,
                    UnitTypeList = unitTypes,
                    UnitList = units
                };

                return View(registerViewModel);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //
        // POST: /Account/Register
        [HttpPost]
        [AllowAnonymous]
        public async Task<ActionResult> Register(RegisterViewModel model)
        {
            ContactInfoReader contactInfoReader = new ContactInfoReader();
            PersonReader personReader = new PersonReader();
            PersonTypeReader personTypeReader = new PersonTypeReader();
            UnitReader unitReader = new UnitReader();
            //Because we can have people that are unaffiliated, we can have a valid model, but still not 
            // work for the application.  We need to check if the person is not affiliated and then we 
            // can determine if we can let it pass or not.
            if (!model.NotUnitAffiliated)
            {
                if (model.PersonType == null || model.PersonType.Length <= 0)
                {
                    ModelState.AddModelError("Classification", "Person Classification MUST be populated.");
                }
                if (model.UnitType == null || model.UnitType.Length <= 0)
                {
                    ModelState.AddModelError("UnitType", "Unit Type MUST be selected.");
                }
                if (model.Unit == null || model.Unit.Length <= 0)
                {
                    ModelState.AddModelError("Unit", "Unit MUST be selected.");
                }
            }

            if (ModelState.IsValid)
            {
                var user = new ApplicationUser { UserName = model.UserName, Email = model.Email, FirstName = model.FirstName, LastName = model.LastName};
                var result = await UserManager.CreateAsync(user, model.Password);
                if (result.Succeeded)
                {

                    //Assign Role to user Here
                    UserManager.AddToRole(user.Id, model.PersonType == "Leader" ? "Leader" : "User");


                    // Create Person and Contact Info objects in database
                    
                    ContactInfoDTO contactInfo = new ContactInfoDTO()
                    {
                        Name = model.FirstName + " " + model.LastName,
                        HomePhone = model.HomePhone,
                        CellPhone = model.CellPhone,
                        Email = model.Email,
                        Address1 = model.Address1,
                        Address2 = model.Address2,
                        City = model.City,
                        State = model.State,
                        Zip = model.Zip
                    };
                    List<ContactInfoDTO> contactInfoList = new List<ContactInfoDTO>();
                    contactInfoList.Add(contactInfo);

                    contactInfoList = contactInfoReader.Save(contactInfoList); 
                    
                    List<PersonDTO> personList = new List<PersonDTO>();
                    if (model.NotUnitAffiliated)
                    {
                        //Person Type, Unit Type, and Unit are not going to be selected.
                        PersonDTO person = new PersonDTO()
                        {
                            FirstName = model.FirstName,
                            MiddleName = model.MiddleName,
                            LastName = model.LastName,
                            LastUpdated = DateTime.Now,
                            ContactInfo = contactInfoList[0],
                            ParentPerson = null,
                            PersonType = null,
                            Rank = null,
                            Unit = null,
                            BirthDate = DateTime.Parse("1/1/1900"),
                            UserId = user.Id
                        };
                        personList.Add(person);    
                    }
                    else
                    {
                        var personType = personTypeReader.GetById(int.Parse(model.PersonType));
                        var unit = unitReader.GetById(int.Parse(model.Unit));
                        PersonDTO person = new PersonDTO()
                        {
                            FirstName = model.FirstName,
                            MiddleName = model.MiddleName,
                            LastName = model.LastName,
                            LastUpdated = DateTime.Now,
                            ContactInfo = contactInfoList[0],
                            ParentPerson = null,
                            PersonType = personType[0],
                            Rank = null,
                            Unit = unit[0],
                            BirthDate = DateTime.Parse("1/1/1900"),
                            UserId = user.Id
                        };
                        personList.Add(person);    
                    }

                    personReader.Save(personList);
                    
                    //await SignInManager.SignInAsync(user, isPersistent: false, rememberBrowser: false);

                    // For more information on how to enable account confirmation and password reset please visit http://go.microsoft.com/fwlink/?LinkID=320771
                    // Send an email with this link
                    //string confirmCode = await UserManager.GenerateEmailConfirmationTokenAsync(user.Id);
                    //SendValidationCodeEmail(user, model.FirstName + " " + model.LastName, confirmCode);

                    return RedirectToAction("RegistrationComplete", "Account", new {email = user.Email});
                    //return RedirectToAction("ConfirmEmail", "Account", new { userId = user.Id, code = confirmCode });

                     //await UserManager.SendEmailAsync(user.Id, "Confirm your account", "Please confirm your account by clicking <a href=\"" + callbackUrl + "\">here</a>");
                    
                    //return RedirectToLocal(model.ReturnUrl);
                }
                AddErrors(result);
            }
            personTypeReader = new PersonTypeReader();
            UnitTypeReader unitTypeReader = new UnitTypeReader();
           
            var personTypes = personTypeReader.GetList().Where(p => p.PersonTypeId > 0).ToList();
            var unitTypes = unitTypeReader.GetList().Where(p => p.UnitTypeId > 0).ToList();
            List<UnitDTO> units = null;
            if (model.UnitType != null)
            {
                units = unitReader.GetList().Where(p => p.UnitType.UnitTypeId == int.Parse(model.UnitType)).ToList();
            }
            else
            {
                units = unitReader.GetList().Where(p => p.UnitType.UnitTypeId == unitTypes[0].UnitTypeId).ToList();
            }
            model.NotUnitAffiliated = false;
            model.PersonTypeList = personTypes;
            model.UnitTypeList = unitTypes;
            model.UnitList = units;
            model.StateList = Utilities.States;
            // If we got this far, something failed, redisplay form
            return View(model);
        }

        [AllowAnonymous]
        public ActionResult RegistrationComplete(string email)
        {
            ViewBag.registrationEmail = email;
            return View();
        }
        //
        // GET: /Account/ConfirmEmail
        [AllowAnonymous]
        public async Task<ActionResult> ConfirmEmail(string userId, string code)
        {
            if (userId == null || code == null)
            {
                return View("Error");
            }
            var result = await UserManager.ConfirmEmailAsync(userId, code);
            return View(result.Succeeded ? "ConfirmEmail" : "Error");
        }

        //
        // GET: /Account/ForgotPassword
        [AllowAnonymous]
        public ActionResult ForgotPassword()
        {
            return View();
        }

        //
        // POST: /Account/ForgotPassword
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> ForgotPassword(ForgotPasswordViewModel model)
        {
            if (ModelState.IsValid)
            {
                var user = await UserManager.FindByEmailAsync(model.Email);
                if (user == null || !(await UserManager.IsEmailConfirmedAsync(user.Id)))
                {
                    // Don't reveal that the user does not exist or is not confirmed
                    return View("ForgotPasswordConfirmation");
                }

                // For more information on how to enable account confirmation and password reset please visit http://go.microsoft.com/fwlink/?LinkID=320771
                // Send an email with this link
                string code = await UserManager.GeneratePasswordResetTokenAsync(user.Id);
                //var callbackUrl = Url.Action("ResetPassword", "Account", new { userId = user.Id, code = code }, protocol: Request.Url.Scheme);	
	            SendForgotPasswordEmail(user, code);
                // await UserManager.SendEmailAsync(user.Id, "Reset Password", "Please reset your password by clicking <a href=\"" + callbackUrl + "\">here</a>");
                return RedirectToAction("ForgotPasswordConfirmation", "Account");
            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }

        //
        // GET: /Account/ForgotPasswordConfirmation
        [AllowAnonymous]
        public ActionResult ForgotPasswordConfirmation()
        {
            return View();
        }

        //
        // GET: /Account/ResetPassword
        [AllowAnonymous]
        public ActionResult ResetPassword(string code)
        {
            return code == null ? View("Error") : View();
        }

        //
        // POST: /Account/ResetPassword
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> ResetPassword(ResetPasswordViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }
            var user = await UserManager.FindByEmailAsync(model.Email);
            if (user == null)
            {
                // Don't reveal that the user does not exist
                return RedirectToAction("ResetPasswordConfirmation", "Account");
            }
            var result = await UserManager.ResetPasswordAsync(user.Id, model.Code, model.Password);
            if (result.Succeeded)
            {
                return RedirectToAction("ResetPasswordConfirmation", "Account");
            }
            AddErrors(result);
            return View();
        }

        //
        // GET: /Account/ResetPasswordConfirmation
        [AllowAnonymous]
        public ActionResult ResetPasswordConfirmation()
        {
            return View();
        }

        //
        // POST: /Account/ExternalLogin
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult ExternalLogin(string provider, string returnUrl)
        {
            // Request a redirect to the external login provider
            return new ChallengeResult(provider, Url.Action("ExternalLoginCallback", "Account", new { ReturnUrl = returnUrl }));
        }

        //
        // GET: /Account/SendCode
        [AllowAnonymous]
        public async Task<ActionResult> SendCode(string returnUrl, bool rememberMe)
        {
            var userId = await SignInManager.GetVerifiedUserIdAsync();
            if (userId == null)
            {
                return View("Error");
            }
            var userFactors = await UserManager.GetValidTwoFactorProvidersAsync(userId);
            var factorOptions = userFactors.Select(purpose => new SelectListItem { Text = purpose, Value = purpose }).ToList();
            return View(new SendCodeViewModel { Providers = factorOptions, ReturnUrl = returnUrl, RememberMe = rememberMe });
        }

        //
        // POST: /Account/SendCode
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> SendCode(SendCodeViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return View();
            }

            // Generate the token and send it
            if (!await SignInManager.SendTwoFactorCodeAsync(model.SelectedProvider))
            {
                return View("Error");
            }
            return RedirectToAction("VerifyCode", new { Provider = model.SelectedProvider, ReturnUrl = model.ReturnUrl, RememberMe = model.RememberMe });
        }

        //
        // GET: /Account/ExternalLoginCallback
        [AllowAnonymous]
        public async Task<ActionResult> ExternalLoginCallback(string returnUrl)
        {
            var loginInfo = await AuthenticationManager.GetExternalLoginInfoAsync();
            if (loginInfo == null)
            {
                return RedirectToAction("Login");
            }

            // Sign in the user with this external login provider if the user already has a login
            var result = await SignInManager.ExternalSignInAsync(loginInfo, isPersistent: false);
            switch (result)
            {
                case SignInStatus.Success:
                    return RedirectToLocal(returnUrl);
                case SignInStatus.LockedOut:
                    return View("Lockout");
                case SignInStatus.RequiresVerification:
                    return RedirectToAction("SendCode", new { ReturnUrl = returnUrl, RememberMe = false });
                case SignInStatus.Failure:
                default:
                    // If the user does not have an account, then prompt the user to create an account
                    ViewBag.ReturnUrl = returnUrl;
                    ViewBag.LoginProvider = loginInfo.Login.LoginProvider;
                    return View("ExternalLoginConfirmation", new ExternalLoginConfirmationViewModel { Email = loginInfo.Email });
            }
        }

        //
        // POST: /Account/ExternalLoginConfirmation
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> ExternalLoginConfirmation(ExternalLoginConfirmationViewModel model, string returnUrl)
        {
            if (User.Identity.IsAuthenticated)
            {
                return RedirectToAction("Index", "Manage");
            }

            if (ModelState.IsValid)
            {
                // Get the information about the user from the external login provider
                var info = await AuthenticationManager.GetExternalLoginInfoAsync();
                if (info == null)
                {
                    return View("ExternalLoginFailure");
                }
                var user = new ApplicationUser { UserName = model.Email, Email = model.Email };
                var result = await UserManager.CreateAsync(user);
                if (result.Succeeded)
                {
                    result = await UserManager.AddLoginAsync(user.Id, info.Login);
                    if (result.Succeeded)
                    {
                        await SignInManager.SignInAsync(user, isPersistent: false, rememberBrowser: false);
                        return RedirectToLocal(returnUrl);
                    }
                }
                AddErrors(result);
            }

            ViewBag.ReturnUrl = returnUrl;
            return View(model);
        }

        //
        // POST: /Account/LogOff
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult LogOff()
        {
            AuthenticationManager.SignOut(DefaultAuthenticationTypes.ApplicationCookie);
            FormsAuthentication.SignOut();
            Session["MyMenu"] = null;
            return RedirectToAction("Index", "Home");
        }

        //
        // GET: /Account/ExternalLoginFailure
        [AllowAnonymous]
        public ActionResult ExternalLoginFailure()
        {
            return View();
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                if (_userManager != null)
                {
                    _userManager.Dispose();
                    _userManager = null;
                }

                if (_signInManager != null)
                {
                    _signInManager.Dispose();
                    _signInManager = null;
                }
            }

            base.Dispose(disposing);
        }

        #region Helpers
        // Used for XSRF protection when adding external logins
        private const string XsrfKey = "XsrfId";

        private IAuthenticationManager AuthenticationManager
        {
            get
            {
                return HttpContext.GetOwinContext().Authentication;
            }
        }

        private void AddErrors(IdentityResult result)
        {
            foreach (var error in result.Errors)
            {
                ModelState.AddModelError("", error);
            }
        }

        private ActionResult RedirectToLocal(string returnUrl)
        {
            if (Url.IsLocalUrl(returnUrl))
            {
                return Redirect(returnUrl);
            }
            return RedirectToAction("Index", "Home");
        }

        internal class ChallengeResult : HttpUnauthorizedResult
        {
            public ChallengeResult(string provider, string redirectUri)
                : this(provider, redirectUri, null)
            {
            }

            public ChallengeResult(string provider, string redirectUri, string userId)
            {
                LoginProvider = provider;
                RedirectUri = redirectUri;
                UserId = userId;
            }

            public string LoginProvider { get; set; }
            public string RedirectUri { get; set; }
            public string UserId { get; set; }

            public override void ExecuteResult(ControllerContext context)
            {
                var properties = new AuthenticationProperties { RedirectUri = RedirectUri };
                if (UserId != null)
                {
                    properties.Dictionary[XsrfKey] = UserId;
                }
                context.HttpContext.GetOwinContext().Authentication.Challenge(properties, LoginProvider);
            }
        }

        
        #endregion

        private void SendValidationCodeEmail(ApplicationUser user, string personName, string code)
        {
            var callbackUrl = Url.Action("ConfirmEmail", "Account", new { userId = user.Id, code = code }, protocol: Request.Url.Scheme);
            SetEmailSettings();
            System.Net.Mail.MailMessage m = new System.Net.Mail.MailMessage(
            new System.Net.Mail.MailAddress(_outputEmail, "York Day Camp"),
            new System.Net.Mail.MailAddress(user.Email));
            m.Subject = "Email confirmation";
            m.Body = string.Format("Dear {0} <BR/>Thank you for your registration, please click on the below link to complete your registration: <a href=\"{1}\"title=\"User Email Confirm\">CONFIRM ACCOUNT</a>"
                                , personName, callbackUrl);
            m.IsBodyHtml = true;
            System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient(_SmtpServer);
            smtp.UseDefaultCredentials = false;
            smtp.Credentials = new System.Net.NetworkCredential(_SmtpAuthAccount, _SmtpAuthPassword);

            smtp.EnableSsl = false;
            smtp.Send(m);
        }

        private void SendForgotPasswordEmail(ApplicationUser user, string code)
        {
            var callbackUrl = Url.Action("ResetPassword", "Account", new { userId = user.Id, code = code }, protocol: Request.Url.Scheme);
            SetEmailSettings();
            System.Net.Mail.MailMessage m = new System.Net.Mail.MailMessage(
            new System.Net.Mail.MailAddress(_outputEmail, "York Day Camp"),
            new System.Net.Mail.MailAddress(user.Email));
            m.Subject = "Password Reset Request";
            m.Body = string.Format("Dear {0} <BR/>Please click on the below link to reset your password: <a href=\"{1}\"title=\"User Email Confirm\"> RESET PASSWORD</a>",
                               user.UserName, callbackUrl);
            m.IsBodyHtml = true;
            System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient(_SmtpServer);
            smtp.UseDefaultCredentials = false;
            smtp.Credentials = new System.Net.NetworkCredential(_SmtpAuthAccount, _SmtpAuthPassword);

            smtp.EnableSsl = false;
            smtp.Send(m);
        }

        private void SetEmailSettings()
        {
            _SmtpServer = ConfigurationManager.AppSettings["SmtpServer"];
            _SmtpAuthAccount = ConfigurationManager.AppSettings["SmtpAuthAccount"];
            _SmtpAuthPassword = "clKi088@";
            _outputEmail = ConfigurationManager.AppSettings["OutboundEmail"];
            _ccEmails = ConfigurationManager.AppSettings["CCEmails"].Split(';');
        }
    }
}
