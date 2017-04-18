var baseURL = window.location.host;
var REG_SERVICE_URL = "http://" + baseURL + "/api/RegistrationDash/";

var gridRegDataStore = new DevExpress.data.CustomStore({
    load: function (loadOptions) {
        return $.ajax({
            dataType: "JSON",
            url: REG_SERVICE_URL,
            contentType: "application/json; charset=utf-8",
            type: "GET",
            data: { id: model.UnitId }
        });
    },
    insert: function (values) {
        return $.ajax({
            url: REG_SERVICE_URL,
            method: "POST",
            data: values
        });
    },
    remove: function (key) {
        return $.ajax({
            url: REG_SERVICE_URL + encodeURIComponent(key),
            method: "DELETE",
        });
    },
    update: function (key, values) {
        return $.ajax({
            url: REG_SERVICE_URL + encodeURIComponent(key),
            method: "PUT",
            data: values
        });
    }
});

var regDataSource = new DevExpress.data.DataSource({
    store: gridRegDataStore
});
var testData = [{
    "id": 4, "registrationDate": "2017-02-28T19:05:04",
    "confirmation": "71adda6be81a9ed",
    "eventId": 1,
    "name": "Will Flowers",
    "dob": "2004-10-04T00:00:00",
    "rank": "Arrow of Light",
    "unit": "Pack 349",
    "notes": "Allergic to Penicillin",
    "parentName": "Robert Flowers",
    "email": "flowersr99@gmail.com",
    "homePhone": "(803)628-1949",
    "cellPhone": "(803)984-5211",
    "address": "1026 W. Mount Gallant Rd.",
    "city": "York",
    "state": "SC",
    "zip": "29745"
}];

$(function () {
    $("#gridRegistration").dxDataGrid({
        dataSource: regDataSource,
        columns: [
            { dataField: "id", caption: "Id", allowEditing: false, width: 45 },
            { dataField: "name", caption: "Scout Name", width: 140, fixed: true },
            { dataField: "unit", caption: "Unit", width: 140, groupIndex: 0 },
            { dataField: "rank", caption: "Rank", width: 100 },
            { dataField: "dob", caption: "Birthday", dataType: "date", width: 90 },
            { dataField: "notes", caption: "Notes", width: 160 },
            { dataField: "parentName", caption: "Parent", width: 140 },
            { dataField: "email", caption: "Email", width: 150},
            { dataField: "homePhone", caption: "Home #", width: 120 },
            { dataField: "cellPhone", caption: "Cell #", width: 120 },
            { dataField: "address", caption: "Address", width: 210 },
            { dataField: "city", capition: "City", width: 85 },
            { dataField: "state", caption: "State", width: 45 },
            { dataField: "zip", caption: "Zip-Code", width: 100 }
        ]
        ,paging: {
            pageSize: 25
        },
        pager: {
            showPageSizeSelector: true,
            allowedPageSizes: [25, 50, 100],
            showInfo: true
        },
        "export": {
            enabled: true,
            fileName: "Registrations",
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