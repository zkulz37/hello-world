<!-- #include file="../../../system/lib/form.inc"  -->
<%@ Register Assembly="FreeTextBox" Namespace="FreeTextBoxControls" TagPrefix="ftb" %>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
    
  </head>
 <%ESysLib.SetUser("comm")%>
 <script>
    function BodyInit(){
        System.Translate(document); 
        datNews.StatusInsert();
        OnInit();	
    }
    function OnInit(){
        txtName.text = '<%=Session("USER_NAME") %>';
        var pk = '<%=request.QueryString("pk")%>';
        txtNewsPK.text = "0";
        txtNewsTemp.text = "0";
        if(pk.length != 0){
            datNews.StatusUpdate();
            txtNewsPK.text = pk;
            datInitNews.Call("SELECT");            
        }
    }
    function OnRedirect(page){
        var lc = location.href;
        var arr = lc.split("/");
        lc = "";
        for(var x=0; x<arr.length-1; x++){
            lc += arr[x] + "/";
        }
        location.href = lc + page;
    }
    function OnReload(){
        location.reload(true);
        //var page = 'agas0020_view.aspx?tp=' + '<%=request.QueryString("tp")%>' + '&pk=' + '<%=request.QueryString("pk")%>';
        //OnRedirect(page);
    }  
    function OnSave(index){
        switch(index){
            case 0:
                if(txtTitle.GetData().length == 0){
                    alert("Please input title!");
                    txtTitle.GetControl().focus();
                    return;}
                if(txtName.GetData().length == 0){
                    alert("Please input display name!");
                    txtName.GetControl().focus();
                    return;}
                var obj = document.getElementById('<%=ftbContent.ClientID %>');
                if(obj.value.length == 0 || obj.value.length > 31000){
                    if(obj.value.length == 0)
                        alert("Please input content!");
                    else
                        alert("Sorry! Data very long!");
                    return;}
                OnSubmit();
            break;
        }
    }
    function OnDelele(){
        if(confirm("Are you sure to delete this news?")){
        datNews.StatusDelete();
        txtNewsPK.text = '<%=request.QueryString("pk")%>';
        txtNewsTemp.text = "0";
        txtNewsType.text = "0";
        txtTitle.text = "0";
        txt_HTMLdoc.text = "0";
        txtName.text = "0";
        txtNewsDate.text = "0";
        datNews.Call();}
    }
    function OnSubmit(){
        var obj = document.getElementById('<%=ftbContent.ClientID %>').value.innerText;
        txt_HTMLdoc.text = document.getElementById('<%=ftbContent.ClientID %>').value;
        txtNewsType.text = '<%=request.QueryString("tp")%>';
        datNews.Call();
        return;
    }
    function OnDataReceive(obj){
        if (obj.id=="datNews"){
            //alert(txtNewsPK.text);
            if(txtNewsPK.text == "0" || txtNewsPK.text == "" || txtNewsPK.text == null)
                OnRedirect('agas0020_list.aspx?tp=' + '<%=request.QueryString("tp")%>');
            else
                OnRedirect('agas0020_view.aspx?tp=' + '<%=request.QueryString("tp")%>' + '&pk=' + txtNewsPK.GetData());
        }
        if (obj.id=="datInitNews"){
            FTB_API['ftbContent'].SetHtml(""); 
            FTB_API['ftbContent'].InsertHtml(txt_HTMLdoc.text); 
        }
    }
    function OnDataError(oData){
    }
</script>
<body>
    <gw:data id="datInitNews" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="1" type="control" function="comm.sp_sel_agas0020"> 
                <inout>
                    <inout bind="txtNewsPK" />
                    <inout bind="txtNewsTemp" />
                    <inout bind="txtNewsTemp" />
                    <inout bind="txtNewsTemp" />
                    <inout bind="txtNewsType" />
                    <inout bind="txtTitle" />
                    <inout bind="txt_HTMLdoc" />
                    <inout bind="txtName" />
                    <inout bind="txtNewsDate" />
                </inout>
            </dso>
        </xml>
    </gw:data>
    <!------------------------------>
    <gw:data id="datNews" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="2" type="control" parameter="0,1,2,3,4,5,6,7,8" function="comm.sp_sel_agas0020" procedure="comm.sp_upd_agas0020"> 
                <inout>
                    <inout bind="txtNewsPK" />
                    <inout bind="txtNewsTemp" />
                    <inout bind="txtNewsTemp" />
                    <inout bind="txtNewsTemp" />
                    <inout bind="txtNewsType" />
                    <inout bind="txtTitle" />
                    <inout bind="txt_HTMLdoc" />
                    <inout bind="txtName" />
                    <inout bind="txtNewsDate" />
                </inout>
            </dso>
        </xml>
    </gw:data>
    <!------------------------------>
    <form runat="server">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td align="center" style="padding-top:20px;padding-right:0px">
                    <table cellpadding="0" cellspacing="0" width="700px" style="border:1px solid;border-color:#333333">
                        <tr>
                            <td align="left" style="padding: 5px 5px 5px 5px">
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td valign="middle" align="right" style="width:100px;padding-right:5px;height:40px;">
                                            Title <span style="color:Red">*</span>
                                        </td>
                                        <td align="left">
                                            <gw:textarea id="txtTitle" styles="width:100%;height:40px;border:1px solid;border-color:#333333;background-color:#e9e9e9" />
                                        </td>
                                    </tr>
                                    <tr runat="server">
                                        <td valign="middle" align="right" style="width:100px;padding-right:5px;">
                                            Display Name <span style="color:Red">*</span>
                                        </td>
                                        <td align="left" style="padding-left:1px;padding-bottom:2px">
                                            <gw:textbox id="txtName" styles="width:50%;border:1px solid;border-color:#333333;background-color:#e9e9e9"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td valign="top" align="right" style="width:100px;padding-right:5px;height:25px" runat="server">
                                            Content <span style="color:Red">*</span>
                                        </td>
                                        <td align="left" style="padding-left:1px">
                                            <ftb:freetextbox id="ftbContent" runat="server" height="220px" imagegallerypath="../ci/picture/" supportfolder="~/FreeTextBox/"  width="100%" BreakMode="LineBreak" ToolbarLayout="FontFacesMenu, FontSizesMenu, FontForeColorsMenu,FontForeColorPicker, FontBackColorsMenu, FontBackColorPicker | JustifyLeft, JustifyRight, JustifyCenter, JustifyFull, BulletedList, NumberedList, Indent, Outdent , InsertDate, InsertTime ,RemoveFormat| Bold, Italic, Underline, Strikethrough, Superscript, Subscript ,InsertRule, CreateLink, Unlink, InsertImageFromGallery,InsertTable, InsertTableRowAfter, DeleteTableRow, InsertTableColumnBefore, InsertTableColumnAfter,DeleteTableColumn,SymbolsMenu,WordClean" ImageGalleryUrl="../ci/ftb.imagegallery.aspx?rif={0}&cif={0}"></ftb:freetextbox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="right" style="padding-top:5px">
                                            <table cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td style="width:100%"></td>
                                                    <td style="padding-left:5px"><gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave(0)" /></td>
                                                    <td style="padding-left:5px"><gw:imgbtn id="btnReset" img="reset" alt="Reset" text="Reset" onclick="OnReload();" /></td>
                                                    <td style="padding-left:5px"><gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="return OnDelele();" /></td>
                                                    <td style="padding-left:5px"><gw:imgbtn id="btnCancel" img="cancel" alt="Cancel" text="Cancel" onclick="OnRedirect('agas0020_list.aspx?tp=<%=request.QueryString("tp")%>')" /></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <gw:textbox id="txtNewsPK" maxlen="100" styles='width:100%;display:none' />
        <gw:textbox id="txtNewsTemp" maxlen="100" styles='width:100%;display:none' />
        <gw:textbox id="txtNewsDate" maxlen="100" styles='width:100%;display:none' />
        <gw:textbox id="txtNewsType" maxlen="100" styles='width:100%;display:none' />
        <gw:textbox id="txt_HTMLdoc" maxlen="4000" styles='width:100%;display:none' csstype="" />
    </form>
</body>
</html>
