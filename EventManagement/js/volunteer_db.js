var VOL_SERVICE_URL = "http://localhost:50337/api/VolunteerDash/";
//var volData = [{ "id": 15, "name": "Robert Flowers", "dob": "1975-11-30T00:00:00", "unit": "Pack 349", "email": "flowersr99@gmail.com", "homePhone": "(803)628-1949", "cellPhone": "(803)984-5211", "address": "1026 W. Mount Gallant Rd.", "city": "York", "state": "SC", "zip": "29745", "volunteerDays": 5, "mondayVol": true, "tuesdayVol": true, "wednesdayVol": true, "thursdayVol": true, "fridayVol": true, "saturdayVol": false, "sundayVol": false, "volunteerDayDisplay": "Mon,Tues,Wed,Thurs,Fri" }, { "id": 16, "name": "Lauren Flowers", "dob": "2001-12-25T00:00:00", "unit": "Pack 349", "email": "flowersr99@gmail.com", "homePhone": "(803)628-1949", "cellPhone": "(803)984-5211", "address": "1026 W. Mount Gallant Rd.", "city": "York", "state": "SC", "zip": "29745", "volunteerDays": 4, "mondayVol": true, "tuesdayVol": true, "wednesdayVol": true, "thursdayVol": false, "fridayVol": true, "saturdayVol": false, "sundayVol": false, "volunteerDayDisplay": "Mon,Tues,Wed,Fri" }];
var gridVolDataStore = new DevExpress.data.CustomStore({
    load: function (loadOptions) {
        return $.getJSON(VOL_SERVICE_URL);
    },
    insert: function (values) {
        return $.ajax({
            url: VOL_SERVICE_URL,
            method: "POST",
            data: values
        })
    },
    remove: function (key) {
        return $.ajax({
            url: VOL_SERVICE_URL + encodeURIComponent(key),
            method: "DELETE",
        })
    },
    update: function (key, values) {
        return $.ajax({
            url: VOL_SERVICE_URL + encodeURIComponent(key),
            method: "PUT",
            data: values
        })
    }
});

var volDataSource = new DevExpress.data.DataSource({
    store: gridVolDataStore
});

$(function () {
    $("#gridVolunteers").dxDataGrid({
        dataSource: volDataSource,
        columns: [
            { dataField: "id", caption: "Id", allowEditing: false, width: 45 },
            { dataField: "name", caption: "Volunteer Name", width: 140, fixed: true },
            { dataField: "unit", caption: "Unit", width: 140, groupIndex: 0 },
            { dataField: "dob", caption: "Birthday", dataType: "date", width: 90 },
            { dataField: "address", caption: "Address", width: 210 },
            { dataField: "city", capition: "City", width: 85 },
            { dataField: "state", caption: "State", width: 45 },
            { dataField: "zip", caption: "Zip-Code", width: 100 },
            { dataField: "volunteerDayDisplay", caption: "Vol. Days", width: 175 }
            ],
        paging: {
            pageSize: 25
        },
        pager: {
            showPageSizeSelector: true,
            allowedPageSizes: [25, 50, 100],
            showInfo: true
        },
        "export": {
            enabled: true,
            fileName: "Volunteers",
            allowExportSelectedData: true
        },
        grouping: {
            autoExpandAll: true,
        },
        filterRow: {
            visible: true,
            applyFilter: "auto"
        },
        searchPanel: {
            visible: true,
            width: 240,
            placeholder: "Search..."
        },
        headerFilter: {
            visible: true
        },
        sorting: { mode: 'multiple' },
        grouping: { contextMenuEnabled: true },
        groupPanel: { visible: true },
        headerFilter: { visible: true },
        showColumnLines: true,
        showRowLines: true,
        rowAlternationEnabled: true
        //masterDetail: {
        //    enabled: true,
        //    template: function (container, options) {
        //        var currentVolunteer = options.data;
        //        container.addClass("internal-grid-container");
        //        $("<div>").text("Volunteer Details").appendTo(container);
        //        $("<div>")
        //            .addClass("internal-grid")
        //            .dxDataGrid({
        //                columnAutoWidth: true,
        //                columns: [{
        //                    caption: "Mon.",
        //                    dataField: "MondayVol",
        //                    width: 50
        //                },
        //                {
        //                    caption: "Tues.",
        //                    dataField: "TuesdayVol",
        //                    width: 50
        //                },
        //                {
        //                    caption: "Wed.",
        //                    dataField: "WednesdayVol",
        //                    width: 50

        //                }, {
        //                    caption: "Thur.",
        //                    dataField: "ThursdayVol",
        //                    width: 50
        //                }, {
        //                    caption: "Fri.",
        //                    dataField: "FridayVol",
        //                    width: 50
        //                }

        //                ],
        //                dataSource: currentVolunteer.VolunteerDetails
        //            }).appendTo(container);
        //    }
        //}
    });
});