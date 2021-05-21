Imports Microsoft.VisualBasic
Imports DevExpress.Web
Imports System
Imports System.Web.UI

Partial Public Class _Default
	Inherits Page
	Private Property CurrentCategoryID() As String
		Get
			Return If(Session("CategoryID") Is Nothing, String.Empty, Session("CategoryID").ToString())
		End Get
		Set(ByVal value As String)
			Session("CategoryID") = value
		End Set
	End Property
	Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
		If (Not IsPostBack) Then
			CurrentCategoryID = String.Empty
		End If
	End Sub
	Protected Sub DetailsButton_Load(ByVal sender As Object, ByVal e As EventArgs)
		Dim btn As ASPxButton = TryCast(sender, ASPxButton)
		Dim container As GridViewDataItemTemplateContainer = TryCast(btn.NamingContainer, GridViewDataItemTemplateContainer)
		Dim categoryID As String = DataBinder.Eval(container.DataItem, "CategoryID").ToString()
		btn.ClientSideEvents.Click = String.Format("function (s, e) {{ OnClick(s, e, {0}) }}", categoryID)
	End Sub
	Protected Sub DetailGrid_Init(ByVal sender As Object, ByVal e As EventArgs)
		DetailsApply()
	End Sub
	Protected Sub Popup_WindowCallback(ByVal source As Object, ByVal e As PopupWindowCallbackArgs)
		CurrentCategoryID = e.Parameter
		DetailsApply()
	End Sub
	Private Sub DetailsApply()
		If (Not String.IsNullOrEmpty(CurrentCategoryID)) Then
			DetailSource.SelectParameters("CategoryID").DefaultValue = CurrentCategoryID
			DetailGrid.DataBind()
		End If
	End Sub
End Class