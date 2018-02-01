$(document)
    .ready(function () {

        $("#UnitType")
            .change(function () {
                var id = Number($(this).val());
                //alert("Selected");
                if (id > 0) {
                    $.ajax({
                        //url: '@Url.Action("GetUnits", "Lookup")',
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
                            var selectedText = $("#UnitType option:selected").text();
                            $("#CubRanks").toggle(selectedText == "Pack");
                        },
                        error: function (xhr) {
                            alert(xhr.responseText);
                        }
                    });
                    $.ajax({
                        url: "../../Lookup/GetRanks",
                        contentType: "application/json; charset=utf-8",
                        type: "GET",
                        dataType: "json",
                        data: { "typeId": id },
                        success: function (data) {
                            $("#Rank").empty();
                            var items = '<option>Select a Rank</option>';
                            for (var i = 0; i < data.length; i++) {
                                items += "<option value='" + data[i].Value + "'>" + data[i].Text + "</option>";
                            }
                            $("#Rank").html(items);
                            $("#Rank").prop("disabled", false);
                        },
                        error: function (xhr) {
                            alert(xhr.responseText);
                        }
                    });
                }
                else {
                    $("#Unit").empty();
                    $("#Unit").prop("disabled", true);
                    $("#Rank").empty();
                    $("#Rank").prop("disabled", true);
                }

            });
    });
$("[data-toggle=datepicker]").each(function () {
    var target = $(this).data("target-name");
    var t = $("input[name=" + target + "]");
    t.datepicker({
        changeMonth: true,
        changeYear: true
    });
    $(this).on("click", function () {
        t.datepicker("show");
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
                var selectedText = $("#UnitType option:selected").text();
                $("#CubRanks").toggle(selectedText == "Pack");
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
