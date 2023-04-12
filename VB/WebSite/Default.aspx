<%@ Page Language="VB" AutoEventWireup="true" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.15.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <script type="text/javascript">
        function OnClick(s, e, categoryID) {
            Popup.PerformCallback(categoryID);
            Popup.Show();
        }
    </script>
    <form id="form1" runat="server">
        <div>
            <dx:ASPxGridView ID="MasterGrid" ClientInstanceName="MasterGrid" runat="server" AutoGenerateColumns="False" DataSourceID="MasterSource" KeyFieldName="CategoryID">
                <Columns>
                    <dx:GridViewDataTextColumn FieldName="CategoryID" ReadOnly="True" VisibleIndex="0">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="CategoryName" VisibleIndex="1">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="2">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataColumn FieldName="DetailButtons" VisibleIndex="3">
                        <DataItemTemplate>
                            <dx:ASPxButton ID="DetailButton" runat="server" Text="Show details" AutoPostBack="false" OnLoad="DetailsButton_Load">
                            </dx:ASPxButton>
                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                </Columns>
            </dx:ASPxGridView>
            <dx:ASPxPopupControl ID="Popup" ClientInstanceName="Popup" runat="server" ShowCloseButton="false" CloseAction="OuterMouseClick"
                OnWindowCallback="Popup_WindowCallback" Modal="true" PopupAction="None" PopupElementID="MasterGrid" PopupHorizontalAlign="Center" PopupVerticalAlign="Middle">
                <ContentCollection>
                    <dx:PopupControlContentControl>
                        <dx:ASPxGridView ID="DetailGrid" runat="server" DataSourceID="DetailSource" AutoGenerateColumns="False" OnInit="DetailGrid_Init">
                            <Columns>
                                <dx:GridViewDataTextColumn FieldName="ProductID" ShowInCustomizationForm="True" VisibleIndex="0">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="ProductName" ShowInCustomizationForm="True" VisibleIndex="1">
                                </dx:GridViewDataTextColumn>
                            </Columns>
                        </dx:ASPxGridView>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>
            <dx:ASPxButton ID="PostbackButton" runat="server" Text="Postback"></dx:ASPxButton>
            <asp:SqlDataSource ID="MasterSource" runat="server"
                ConnectionString="<%$ ConnectionStrings:NwindConnectionString %>"
                SelectCommand="SELECT * FROM [Categories]"></asp:SqlDataSource>
            <asp:SqlDataSource ID="DetailSource" runat="server"
                ConnectionString="<%$ ConnectionStrings:NwindConnectionString %>"
                SelectCommand="SELECT [ProductID], [ProductName] FROM [Products] WHERE [CategoryID] = @CategoryID">
                <SelectParameters>
                    <asp:Parameter Name="CategoryID" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
