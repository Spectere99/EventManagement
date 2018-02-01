$(document)
    .ready(function() {

       

        $("#NotUnitAffiliated")
            .click(function () {
                $("#lblPersonTypeList").toggle(!this.checked);
                $("#PersonType").toggle(!this.checked);
                $("#lblUnitTypeList").toggle(!this.checked);
                $("#UnitType").toggle(!this.checked);
                $("#lblUnitList").toggle(!this.checked);
                $("#Unit").toggle(!this.checked);
            });


        $("#UnitType")
            .change(function() {
                var id = Number($(this).val());
                //alert("Selected");
                if (id > 0) {
                    $.ajax({
                        url: "../../Lookup/GetUnits",
                        contentType: "application/json; charset=utf-8",
                        type: "GET",
                        dataType: "json",
                        data: { "typeId": id },
                        success: function(data) {
                            $("#Unit").empty();
                            var items = '<option>Select a Unit</option>';
                            for (var i = 0; i < data.length; i++) {
                                items += "<option value='" + data[i].Value + "'>" + data[i].Text + "</option>";
                            }
                            $("#Unit").html(items);
                            $("#Unit").prop("disabled", false);
                        },
                        error: function(xhr) {
                            alert(xhr.responseText);
                        }
                    });
                } else {
                    $("#Unit").empty();
                    $("#Unit").prop("disabled", true);
                }

            });
    });
function FillUnits() {
    var id = Number($("#UnitType").val());
    //alert("Selected");
    if (id > 0) {
        $.ajax({
            url: "../../Lookup/GetUnits",
            contentType: "application/json; charset=utf-8",
            type: "GET",
            dataType: "json",
            data: { "typeId": id },
            success: function (data) {
                $("#Unit").empty();
                var items = '<option>Select a Unit</option>';
                for (var i = 0; i < data.length; i++) {
                    items += "<option value='" + data[i].Value + "'>" + data[i].Text + "</option>";
                }
                $("#Unit").html(items);
                $("#Unit").prop("disabled", false);
            },
            error: function (xhr) {
                alert(xhr.responseText);
            }
        });
    } else {
        $("#Unit").empty();
        $("#Unit").prop("disabled", true);
    }
}
