var baseURL = window.location.host;

var VOL_SERVICE_URL = "http://" + baseURL + "/api/VolunteerDash/";

var gridVolDataStore = new DevExpress.data.CustomStore({
    load: function (loadOptions) {
        return $.ajax({
            dataType: "JSON",
            url: VOL_SERVICE_URL,
            contentType: "application/json; charset=utf-8",
            type: "GET",
            data: { id: model.UnitId }
        });
    },
    insert: function (values) {
        return $.ajax({
            url: VOL_SERVICE_URL,
            method: "POST",
            data: values
        });
    },
    remove: function (key) {
        return $.ajax({
            url: VOL_SERVICE_URL + encodeURIComponent(key),
            method: "DELETE",
        });
    },
    update: function (key, values) {
        return $.ajax({
            url: VOL_SERVICE_URL + encodeURIComponent(key),
            method: "PUT",
            data: values
        });
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
        
    });
});