var VOL_SERVICE_URL = "http://localhost:50337/api/VolunteerDash/";

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
            { dataField: "Id", caption: "Id", allowEditing: false, width: 45 },
            { dataField: "Name", caption: "Volunteer Name", width: 140, fixed: true },
            { dataField: "Unit", caption: "Unit", width: 140, groupIndex: 0 },
            { dataField: "DOB", caption: "Birthday", dataType: "date", width: 90 },
            { dataField: "Address", caption: "Address", width: 210 },
            { dataField: "City", capition: "City", width: 85 },
            { dataField: "State", caption: "State", width: 45 },
            { dataField: "Zip", caption: "Zip-Code", width: 100 },
            { dataField: "VolunteerDayDisplay", caption: "Vol. Days", width: 175 }
            ]
        //],
        //paging: {
        //    pageSize: 25
        //},
        //pager: {
        //    showPageSizeSelector: true,
        //    allowedPageSizes: [25, 50, 100],
        //    showInfo: true
        //},
        //"export": {
        //    enabled: true,
        //    fileName: "Volunteers",
        //    allowExportSelectedData: true
        //},
        //grouping: {
        //    autoExpandAll: true,
        //},
        //filterRow: {
        //    visible: true,
        //    applyFilter: "auto"
        //},
        //searchPanel: {
        //    visible: true,
        //    width: 240,
        //    placeholder: "Search..."
        //},
        //headerFilter: {
        //    visible: true
        //},
        //sorting: { mode: 'multiple' },
        //grouping: { contextMenuEnabled: true },
        //groupPanel: { visible: true },
        //headerFilter: { visible: true },
        //showColumnLines: true,
        //showRowLines: true,
        //rowAlternationEnabled: true
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