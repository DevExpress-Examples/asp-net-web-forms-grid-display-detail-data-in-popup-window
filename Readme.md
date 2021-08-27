<!-- default badges list -->
![](https://img.shields.io/endpoint?url=https://codecentral.devexpress.com/api/v1/VersionRange/128539410/19.2.3%2B)
[![](https://img.shields.io/badge/Open_in_DevExpress_Support_Center-FF7200?style=flat-square&logo=DevExpress&logoColor=white)](https://supportcenter.devexpress.com/ticket/details/E5202)
[![](https://img.shields.io/badge/📖_How_to_use_DevExpress_Examples-e9f6fc?style=flat-square)](https://docs.devexpress.com/GeneralInformation/403183)
<!-- default badges end -->
<!-- default file list -->
*Files to look at*:

* [Default.aspx](./CS/WebSite/Default.aspx) (VB: [Default.aspx](./VB/WebSite/Default.aspx))
* [Default.aspx.cs](./CS/WebSite/Default.aspx.cs) (VB: [Default.aspx.vb](./VB/WebSite/Default.aspx.vb))
<!-- default file list end -->
# How to display detail data within a popup window using ASPxPopupControl content elements
<!-- run online -->
**[[Run Online]](https://codecentral.devexpress.com/e5202/)**
<!-- run online end -->


The <a href="https://www.devexpress.com/Support/Center/p/E2193">E2193: How to display detail data within a popup window</a> example illustrates how to implement a master-detail scenario using the **ASPxGridView** and **ASPxPopupControl** controls.

### Steps to implement:
1. Use a data item template. Place a button to a template:
```aspx
<dx:GridViewDataColumn FieldName="DetailButtons" VisibleIndex="3">
    <DataItemTemplate>
        <dx:ASPxButton ID="DetailButton" runat="server" Text="Show details" AutoPostBack="false" OnLoad="DetailsButton_Load">
        </dx:ASPxButton>
    </DataItemTemplate>
</dx:GridViewDataColumn>
```
2. Handle this button's `Load` event and pass a key to the client-side `Click` event of this button:
```csharp
protected void DetailsButton_Load(object sender, EventArgs e) {
    ASPxButton btn = sender as ASPxButton;
    GridViewDataItemTemplateContainer container = btn.NamingContainer as GridViewDataItemTemplateContainer;
    string categoryID = DataBinder.Eval(container.DataItem, "CategoryID").ToString();
    btn.ClientSideEvents.Click = String.Format("function (s, e) {{ OnClick(s, e, {0}) }}", categoryID);
}
```
3. In the client-side Click event handler, send a callback to a popup to upgrade your detail grid according to the master row value:
```js
function OnClick(s, e, categoryID) {
    Popup.PerformCallback(categoryID);
}
```
4. Handle the `PopupControl.WindowCallback` event to update the Session parameter and rebind your detail grid:
```csharp
protected void Popup_WindowCallback(object source, PopupWindowCallbackArgs e) {
    CurrentCategoryID = e.Parameter;
    DetailsApply();
}
private void DetailsApply() {
    if (!String.IsNullOrEmpty(CurrentCategoryID)) {
        DetailSource.SelectParameters["CategoryID"].DefaultValue = CurrentCategoryID;
        DetailGrid.DataBind();
    }
}
```
5. In the `ASPxClientPopupControl.EndCallback` event handler, call the Show method:
```js
function OnEndCallback(s, e) {
    Popup.Show();
}
```
