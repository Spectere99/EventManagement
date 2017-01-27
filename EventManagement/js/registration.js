﻿$(document)
    .ready(function() {

        $("#EventList")
            .change(function() {
                var id = Number($("#EventList").val());
                if (id > 0) {
                    $.ajax({
                        //url: '@Url.Action("GetVenueDetails", "Registration")',
                        url: 'Lookup/GetVenueDetails',
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

                                $('#venueDetails').show();
                            }
                        },
                        error: function (xhr) {
                            alert(xhr.responseText);
                        }
                    });
                    $.ajax({
                        url: 'Lookup/GetEventDate',
                        contentType: "application/json; charset=utf-8",
                        type: "GET",
                        dataType: "json",
                        data: { "eventId": id },
                        success: function(eventDates) {
                            if (eventDates != null) {
                                var eDates = eventDates;
                                $("#EventDate").text(eDates);
                            }
                        },
                        error: function (xhr) {
                            alert(xhr.responseText);
                        }
                    });
                    
                }
            });

        $("#NotUnitAffiliated")
            .click(function () {
                $("#lblPersonTypeList").toggle(!this.checked);
                $("#PersonType").toggle(!this.checked);
                $("#lblUnitTypeList").toggle(!this.checked);
                $("#UnitTypeList").toggle(!this.checked);
                $("#lblUnitList").toggle(!this.checked);
                $("#UnitList").toggle(!this.checked);
            });

        $("#UnitTypeList")
            .change(function() {
                var id = Number($(this).val());
                //alert("Selected");
                if (id > 0) {
                    $.ajax({
                        url: "GetUnits",
                        contentType: "application/json; charset=utf-8",
                        type: "GET",
                        dataType: "json",
                        data: { "typeId": id },
                        success: function(data) {
                            $("#UnitList").empty();
                            var items = '<option>Select a Unit</option>';
                            for (var i = 0; i < data.length; i++) {
                                items += "<option value='" + data[i].Value + "'>" + data[i].Text + "</option>";
                            }
                            $("#UnitList").html(items);
                            $("#UnitList").prop("disabled", false);
                        },
                        error: function(xhr) {
                        alert(xhr.responseText);
                    }
                    });
                    $.ajax({
                        url: "GetRanks",
                        contentType: "application/json; charset=utf-8",
                        type: "GET",
                        dataType: "json",
                        data: { "typeId": id },
                        success: function (data) {
                            $("#UnitRankList").empty();
                            var items = '<option>Select a Rank</option>';
                            for (var i = 0; i < data.length; i++) {
                                items += "<option value='" + data[i].Value + "'>" + data[i].Text + "</option>";
                            }
                            $("#UnitRankList").html(items);
                            $("#UnitRankList").prop("disabled", false);
                        },
                        error: function (xhr) {
                            alert(xhr.responseText);
                        }
                    });
                }

            });
    });