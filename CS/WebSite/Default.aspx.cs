using DevExpress.Web;


using System;
using System.Web.UI;

public partial class _Default : Page {
    private string CurrentCategoryID {
        get { return Session["CategoryID"] == null ? String.Empty : Session["CategoryID"].ToString(); }
        set { Session["CategoryID"] = value; }
    }
    protected void Page_Load(object sender, EventArgs e) {
        if (!IsPostBack)
            CurrentCategoryID = String.Empty;
    }
    protected void DetailsButton_Load(object sender, EventArgs e) {
        ASPxButton btn = sender as ASPxButton;
        GridViewDataItemTemplateContainer container = btn.NamingContainer as GridViewDataItemTemplateContainer;
        string categoryID = DataBinder.Eval(container.DataItem, "CategoryID").ToString();
        btn.ClientSideEvents.Click = String.Format("function (s, e) {{ OnClick(s, e, {0}) }}", categoryID);
    }
    protected void DetailGrid_Init(object sender, EventArgs e) {
        DetailsApply();
    }
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
}