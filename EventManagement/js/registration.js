function GetVenueDetails() {
    var id = Number($("#EventList").val());
    $.ajax({
        //url: '@Url.Action("GetVenueDetails", "Registration")',
        url: 'Registration/GetVenueDetails',
        contentType: "application/json; charset=utf-8",
        type: "GET",
        dataType: "json",
        data: { "eventId": id },
        success: function(venue) {
            if (venue != null) {
                var vdata = venue;
                $("#VenueName").text(vdata.Name);
                $("#VenueAddress1").text(vdata.ContactInfo.Address1);
                $("#VenueAddress2").text(vdata.ContactInfo.Address2);
                $("#VenueCity").text(vdata.ContactInfo.City);
                $("#VenueState").text(vdata.ContactInfo.State);
                $("#VenueZip").text(vdata.ContactInfo.Zip);
            }
        },
        error: function (xhr, ajaxOptions, thrownError) {
            alert(xhr.status);
            alert(ajaxOptions);
            alert(thrownError);
        }
    });
}
