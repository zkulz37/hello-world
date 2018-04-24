<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("hr")%>
 <html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>

var strcodereturn; //return data of common code popup to check whether you change data of common code.
var strdata; //data of common code popup
var bdelete=false;
var binit=true;
var b_status="";
var obj_list_code; //temp list of common code list
var v_language = "<%=Session("SESSION_LANG")%>";
var lang= "<%=Session("Lang")%>"; 
var p_thr_business_card_pk = "<%=Request.querystring("thr_business_card_pk")%>" ;
function BodyInit()
{          
    if (v_language!="ENG")
        System.Translate(document);          
        
    
    datBusinessCard_info.StatusInsert();
    
    txtUser_PK.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    txtEmp_PK.text="<%=session("EMPLOYEE_PK")%>"
    BindingData();

    datBiz_Emp_Infor.Call();
    
    txtFULL_NM_E.SetEnable(false);
    txtFULL_NM_V.SetEnable(false);
    txtDEPT_NM_E.SetEnable(false);
    txtDEPT_NM_V.SetEnable(false);
    txtPOS_NM_E.SetEnable(false);
    txtPOS_NM_V.SetEnable(false);
    
    txtApprover_Name.SetEnable(false);
    txtApplication_No.SetEnable(false);
	idBtnSave.SetEnable(false);
}
//--------------------------------------------------
function BindingData()
{
    var ls_data     = "<%=ESysLib.SetListDataSQL("select pk, type_name from thr_unit_cost where CATEGORY_CODE = '30' and del_if = 0 ")%>";
    lstCardType.SetDataText(ls_data);
    lstCardType.value = '';
    txtUnitPrice.SetEnable(false);
    idBtnSubmit.SetEnable(false);   
}
//---------------setup language---------------------
function SetupLanguage()
{
    var tags = new Array();
    //process tag 'td'
    tags = document.all.tags("td");
    
    for(var i=0;i<tags.length;i++)
    {
      var s = new String();
      
      s = tags[i].innerHTML;
      //alert(s);
      if(s !=null){
        if(s.indexOf("/>",0) < 0 && s.indexOf("<IMG",0) < 0 && s.indexOf("<A",0) < 0){
            tags[i].innerHTML="<nobr>" + lookUpDictionary(tags[i].innerText) + "</nobr>";
        }
      }
    }
    //process tag 'label'
    tags = document.all.tags("label");
    for(var i=0;i<tags.length;i++)
    {
      var s = new String();
      
      s = tags[i].text;
      if(s !=""){
            tags[i].text=lookUpDictionary(tags[i].text);
      }
    }
    
    //process tag 'hyperlink'
    tags = document.all.tags("A");
    for(var i=0;i<tags.length;i++)
    {
      var s = new String();
      
      s = tags[i].innerText;
      //alert(s)
      if(s !=""){
            tags[i].innerText=lookUpDictionary(tags[i].innerText);
      }
    }
    
    //process tag 'span'
    tags = document.all.tags("radio");
    for(var i=0;i<tags.length;i++)
    {
      var s = new String();
          var obj = tags[i].childNodes(1);
          s = obj.innerText;
          if(s !=null){
                obj.innerText=lookUpDictionary(obj.innerText);
          }
          obj = tags[i].childNodes(4);
          s = obj.innerText;
          if(s !=null){
                obj.innerText=lookUpDictionary(obj.innerText);
          }
    }
    //process tag 'grid'
    var arrGrid = new Array();
    
    arrGrid = document.all.tags("grid");
    for(var i=0;i<arrGrid.length;i++)
    {
       var obj=arrGrid[i].GetGridControl();
       for(var j=0;j<obj.Cols;j++)
       {
            if(obj.ColHidden(j) == false)
            {
               obj.TextMatrix(0,j)=lookUpDictionary(obj.TextMatrix(0,j));
            }
       }
    }
}
function lookUpDictionary(p_key)
{
    for(var i=0;i<System.S_ArrDict.length;i++){
       var tmp=System.S_ArrDict[i];
       if(Trim(tmp[1].toUpperCase())== Trim(p_key.toUpperCase())){
         if(tmp[2]==""){
            return tmp[1];
         }
         else{
            return tmp[2];
         }
       }
    }
    return p_key;
}
//-----------------------------------------------
function OnShowPopup(strtemp,objlist)
{
    if (strtemp==1 )
    {        
        var strcom
        var fpath = System.RootURL + "/form/ch/mb/chmb00010_emp_id_code.aspx?idcode=Card" ;
        var obj  = System.OpenModal(  fpath , 900 , 450 , 'resizable:yes;status:yes');    
    }
    
}
//--------------------------------------------------
function OnDataReceive(obj)
{   
    switch (obj.id)
    {
        case "datBusinessCard_info":                   
            if(txtStatus.text == '10')
            {
                idBtnSubmit.SetEnable(true);
                idBtnSave.SetEnable(true); 
            }
            else
            {
                idBtnSubmit.SetEnable(false);
                idBtnSave.SetEnable(false); 
            }
            if (b_status == "Insert")
            {
                if (txtApplicant_PK.text!="")
                {
                    alert("Insert Successful! \n Tạo mới thành công");
                    idBtnSubmit.SetEnable(true);
                }                    
                else
                {
                    alert("Insert fail! \n Tạo mới thất bại");
                    idBtnSubmit.SetEnable(false);
                }                    
            }                    
            else if (b_status == "Update" && txtStatus.text == "10")
            {
                if (txtApplicant_PK.text!="")
                {
                    alert("Update Successful! \n Cập nhật thành công");
                    idBtnSubmit.SetEnable(true);
                }                    
                else
                {
                    alert("Update fail! \n Cập nhật thất bại");
                    idBtnSubmit.SetEnable(false);
                }                    
            }       
            else if (b_status == "Update" && txtStatus.text == "20")
            {
                if (txtApplicant_PK.text!="")
                {
                    alert("Submit Successful!");
                    idBtnSubmit.SetEnable(false);
                }                    
                else
                {
                    alert("Submit fail!");                        
                    idBtnSubmit.SetEnable(true);
                }    
            }
            else
            {
                if(txtStatus.text == "10")
                {
                    idBtnSubmit.SetEnable(true);
                }
            }
             break;               
        case "datFind_Applicant":
            if (txtApplicant_PK.text=='-1')
                alert("Do not have this applicant! \n Không có đơn này!");
            else
                datBusinessCard_info.Call("SELECT");
            break;
        case 'dso_Biz_card_Price':
            
        break ;  
        case 'datBiz_Emp_Infor':          
            if(Trim(p_thr_business_card_pk) != '')
            {
                txtApplicant_PK.text = p_thr_business_card_pk ;
                b_status = "";
                idBtnSave.SetEnable(true);
                datBusinessCard_info.Call("SELECT");
                p_thr_business_card_pk = '';                
            }
        break ;
    }
}
//-----------------------------------------------
function Numbers(e) 
{ 
  //  var ctrl=idTEL.GetControl(); 
    var keynum; 
    var keychar; 
    var numcheck; 
    keynum =event.keyCode; 
        
    if(window.event) // IE 
    { 
      keynum = e.keyCode; 
    } 
    else if(e.which) // Netscape/Firefox/Opera 
    { 
      keynum = e.which; 
    } 
    keychar = String.fromCharCode(keynum); 
    numcheck = /\d/; 
    return numcheck.test(keychar); 
}

function onChangeUser(objid)
{
    switch (objid)
    {
        case 1:
        {
            var fpath = System.RootURL + "/form/ch/mb/chmb00010_search_emp.aspx?kind=1" ;
            var obj  = System.OpenModal(  fpath , 900 ,600, 'resizable:yes;status:yes;');
	        if (obj!=null)
	        {
                txtEmp_PK.text=obj[0];
                txtFULL_NM_E.text = obj[2];
                txtFULL_NM_V.text = obj[8];
                txtDEPT_NM_E.text = obj[4];
                txtDEPT_NM_V.text = obj[9];
                txtPOS_NM_E.text = obj[10];
                txtPOS_NM_V.text = obj[11];
                txtPOS_TYPE.text = obj[12];
                txtTEL.text = obj[7];
                txtMAIL.text = obj[24];
                txtApprover_PK.text = obj[15];
                datBiz_Emp_Infor.Call();
	        }
            break;
        }
        case 2:
        {
            var fpath = System.RootURL + "/form/ch/mb/chmb00010_search_emp.aspx?kind=2" ;
            var obj  = System.OpenModal(  fpath , 900 ,600, 'resizable:yes;status:yes;');
	        if (obj!=null)
	        {
                txtApprover_Name.text = obj[2];
                txtApprover_PK.text = obj[0];
	        }
	        break;
	    }
	}
}
//----------------------------------------
function CheckSave()
{
    if (txtEmp_PK.text=="") 
    {
        alert("Please select employee! Vui lòng chọn người nhân viên!");
        return false;
    }
    if (txtApprover_PK.text=="")
    {
        alert("Please select approver! Vui lòng chọn người đi chấp thuận!");
        return false;
    }
    if (lstCardType.value=="")
    {
        alert("Please select card type! Vui lòng chọn loại thẻ!");
        return false;
    }
    if(Trim(idQuantity.text) == '')
    {
        alert('Please input requested quantity...');
        return false;
    }
    else if(Number(idQuantity.text) <= 0)
    {
        alert('Please input requested quantity greater than 0...');
        return false;
    }
    else if (dtRequire.value < dtToday.value )
    {
        alert('Please choose the required must be greater than today');
        return false;
    }
    return true;
}
//------------------------------------------------------
function onSave(n)
{
    switch(n)
    {
        case 1:
        {
            txtStatus.text = "10";      //trang thai update
            if (txtApplicant_PK.text=="")
                {
                    if (CheckSave())
                    {
                        if (confirm("Do you want to insert new data? \n Bạn có muốn tạo mới thông tin?"))
                        {
                            b_status="Insert";							
                            datBusinessCard_info.Call();
                        }
                    }
                }
                else
                {
                    if (confirm("Do you want to save data? \n Bạn có muốn cập nhật thông tin?"))
                    {
                        b_status="Update";
                        datBusinessCard_info.StatusUpdate();
                        datBusinessCard_info.Call();
                    }
                }
             break;   
         }
         case 2:
         {
            if(Trim(txtApplication_No.text) != '')
            {
                txtStatus.text = "20";      //trang thai submit
                if (confirm("Do you want to submit data?"))
                {
                    b_status="Update";
                    datBusinessCard_info.StatusUpdate();
                    datBusinessCard_info.Call();
                    idBtnSave.SetEnable(false);
                }
            }
            else
            {
                return ;
            }
            /*else if(txtStatus.text == '20')
            {
                alert('This business card has already submmited...');
            } */               
            break;
         }
    }            
}

function onReset()
{
    txtApplicant_PK.text = "";
    txtApplication_No.text = "";
    txtFULL_NM_E.text = "";
    txtFULL_NM_V.text = "";
    txtDEPT_NM_V.text = "";
    txtDEPT_NM_E.text = "";
    txtPOS_NM_E.text = "";
    txtPOS_NM_V.text = "";
    txtTEL.text = "";
    txtMOBILE.text = "";
    txtFAX.text = "";
    txtMAIL.text = "";
    txtApprover_Name.text = "";
    txtRemark.text = '';
    txtThr_Unit_cost_pk.text = '';
    lstCardType.value = '';
	datBusinessCard_info.StatusInsert();
    idBtnSave.SetEnable(true);
    idBtnSubmit.SetEnable(false);
}
//----------------------------------------------------------
function onSearch()
{
    var fpath = System.RootURL + "/form/ch/mb/chmb00010_search_business_applicant.aspx" ;
    var obj  = System.OpenModal(  fpath , 900 ,600, 'resizable:yes;status:yes;');
    if (obj!=null)
    {
        txtApplicant_PK.text = obj[0];
        b_status = "";
        idBtnSave.SetEnable(true);
        datBusinessCard_info.Call("SELECT");
    }
}
//-----------------------------------------------------------
function OnSearchType()
{
    txtThr_Unit_cost_pk.text = lstCardType.value ;
    dso_Biz_card_Price.Call();
}
</script>

<body bgcolor='#F5F8FF'>

<!------------------------------------------>
<gw:data id="datBusinessCard_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21" function="hr.sp_sel_business_card_applicant" procedure="HR.sp_upd_business_card_entry"> 
                <inout>
                    <inout bind="txtApplicant_PK" />
                    <inout bind="txtFULL_NM_E" />
                    <inout bind="txtFULL_NM_V" />
                    <inout bind="txtDEPT_NM_E" />
                    <inout bind="txtDEPT_NM_V" />
                    <inout bind="txtPOS_NM_E" />
                    <inout bind="txtPOS_NM_V" />
                    <inout bind="txtTEL" />
                    <inout bind="txtMOBILE" />
                    <inout bind="txtFAX" />
                    <inout bind="txtMAIL" />
                    <inout bind="txtApprover_Name" />
                    <inout bind="lstCardType" />
                    <inout bind="idQuantity" />
                    <inout bind="txtRemark" />
                    <inout bind="txtPOS_TYPE" />
                    <inout bind="txtApplication_No" />
                    <inout bind="txtEmp_PK" />
                    <inout bind="txtStatus" />
                    <inout bind="txtApprover_PK" />                    
                    <inout bind="txtUnitPrice" />
                    <inout bind="dtRequire" />
                </inout>
            </dso> 
        </xml> 
</gw:data>

<!----------------------------------->
<gw:data id="datBiz_Emp_Infor" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_get_biz_empid_business" > 
                <input>
                    <input bind="txtEmp_PK" />
                </input> 
                <output>
                    <output bind="txtEmp_ID" />
                    <output bind="txtFULL_NM_E" />
                    <output bind="txtApprover_ID" />
                    <output bind="txtApprover_Name" />
                    <output bind="txtTmp" />
                    <output bind="txtDEPT_NM_E" />
                    <output bind="txtTmp" />
                    <output bind="txtApprover_PK" />
                    <output bind="txtFULL_NM_V" />
                    <output bind="txtDEPT_NM_V" />
                    <output bind="txtPOS_NM_E" />
                    <output bind="txtPOS_NM_V" />
                    <output bind="txtPOS_TYPE" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="datFind_Applicant" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_find_applicant_business" > 
                <input>                    
                   <input bind="txtApplication_No" />
                </input> 
                <output>
                    <output bind="txtApplicant_PK" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="dso_Biz_card_Price" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_business_card_price" > 
                <input>                    
                   <input bind="txtThr_Unit_cost_pk" />
                </input> 
                <output>
                    <output bind="txtUnitPrice" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<!---------------------main employee tab data control------------------>

<!--<form name="Business Card Entry" id="form1" >-->
     <table id="main" cellpadding="0" cellspacing="0" border=0 style="width:100%;height:100%;">
        <tr style=" height:40%">
            <td>
            <fieldset style="height:50%;" > 
            <legend><font color="fuchsia" size="2" >Basic Information</font></legend>
                <table  width="100%" border="0" cellspacing="1" cellpadding="1" >
                    <tr>
                        <td width=10% align=right><a title="Click here to show employee id code" onclick="OnShowPopup(1,'')" href="#tips" >Application No</a></td>
                        <td width="37%"><gw:textbox id="txtApplication_No"  text="" 	styles='width:30%;' csstype="mandatory"  onenterkey="" /></td>
                        <td width=10%>&nbsp;</td>
                        <td width=10%>&nbsp;</td>
                        <td width=20%>&nbsp;</td>
                        <td align=right style="width:5%;border:0"><gw:icon id="idBtnNew"  styles='width:90%' img="in"  text="New"  onclick="onReset()"/></td>  
                        <td align=right style="width:5%;border:0"><gw:icon id="idBtnSearch"  styles='width:90%' img="in"  text="Search"  onclick="onSearch()"/>
                        <td align=right style="width:5%;border:0"><gw:icon id="idBtnSave"  styles='width:90%' img="in"  text="Save"  onclick="onSave(1)"/></td>
                        <td align=right style="width:5%;border:0"><gw:icon id="idBtnSubmit"  styles='width:90%' img="in"  text="Submit"  onclick="onSave(2)"/></td>
                    </tr>
                    <tr>
                        <td align=right><a title="Click here to select employee" href="#tips" onclick="onChangeUser(1)" >Name (ENG)&nbsp</a></td>
                        <td align=center><gw:textbox id="txtFULL_NM_E"  text="<%=session("USER_NAME")%>" maxlen = "100" styles='color:red;font-weight: bold;font-size:15;width:100%;' onenterkey="" />
                        <td ></td>
                        <td align=right>Name (VN)</td>
                        <td colspan=5 align=center><gw:textbox id="txtFULL_NM_V"  text="" maxlen = "50" styles='width:100%;' onenterkey="" />
                    </tr>
                    <tr>
                        <td align=right>Department (ENG)</td>
                        <td align=center><gw:textbox id="txtDEPT_NM_E"  text="" maxlen = "50" styles='width:100%;' onenterkey="" />
                        <td >&nbsp;</td>
                        <td align=right>Department (VN)</td>
                        <td colspan=5 align=center><gw:textbox id="txtDEPT_NM_V"  text="" maxlen = "50" styles='width:100%;' onenterkey="" />
                    </tr>
                    <tr>
                        <td align=right>Position (ENG)</td>
                        <td align=center><gw:textbox id="txtPOS_NM_E"  text="" maxlen = "50" styles='width:100%;' onenterkey="" />
                        <td >&nbsp;</td>
                        <td align=right>Position (VN)</td>
                        <td colspan=5 align=center><gw:textbox id="txtPOS_NM_V"  text="" maxlen = "50" styles='width:100%;' onenterkey="" />
                    </tr>
                    <tr>
                        <td align=right>Tel</td>
                        <td align=center><gw:textbox id="txtTEL"  text="" maxlen = "15" styles='width:100%;' onenterkey="" />
                        <td >&nbsp;</td>
                        <td align=right>Mobile</td>
                        <td colspan=5 align=center><gw:textbox id="txtMOBILE"  text="" maxlen = "15" styles='width:100%;' onenterkey="" /></td>
                    </tr>
                    <tr>
                        <td align=right>Fax</td>
                        <td align=center><gw:textbox id="txtFAX"  text="" maxlen = "15" styles='width:100%;' onenterkey="" /></td>
                        <td >&nbsp;</td>
                        <td align=right>E-mail</td>
                        <td colspan=5 align=center><gw:textbox id="txtMAIL"  text="" maxlen = "50" styles='width:100%;' onenterkey="" /></td>
                    </tr>
                </table>
            </fieldset>    
            </td>
        </tr>
        <tr style=" height:60%">
            <td>
            <fieldset style="height:50%;" > 
            <legend><font color="fuchsia" size="2" >Order Information</font></legend>
                <table  width="100%" border="0" cellspacing="1" cellpadding="1" style="height:100%" >
                    <tr>
                        <td width=10% align=right>Card Type</td>
                        <td width="15%" align=center><gw:list id="lstCardType"  styles='width:100%;' onchange="OnSearchType()" />
                        </td>
                        <td width="37%" align="right" >Required Date&nbsp;</td>
                        <td width="20%" align="left"><gw:datebox id="dtRequire" styles="width:100%" lang="1" /></td>
                        <td width="18%">&nbsp;</td>
                    </tr>
                    <tr>
                        <td align=right>Request Qty&nbsp;</td>
                        <td align=center><gw:list id="idQuantity" styles="width:100%" >
                                        <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0086' order by code_nm")%></data>
                                        </gw:list> 
                        </td>                                        
                        <td align="right" >Unit Price&nbsp;</td>
                        <td align="left"><gw:textbox id="txtUnitPrice" text="0" type="number" format="###,###,###" /></td>
                        <td colspan=3 align=center>&nbsp;</td>
                    </tr>
                    <tr>
                        <td align=right><a title="Click here to select approver" href="#tips" onclick="onChangeUser(2)">Approver&nbsp;</a></td>
                        <td align=center><gw:textbox id="txtApprover_Name"  text="" maxlen = "10" styles='width:85%;' csstype="mandatory" onenterkey="" />
                        <td ></td>
                        <td align=right>&nbsp;</td>
                        <td colspan=3 align=center>&nbsp;</td>
                    </tr>
                    <tr>
                        <td align=right>Remark&nbsp;</td>
                        <td colspan=6 align=center><gw:textarea id="txtRemark" rows="6" styles='width:100%;' />
                    </tr>
                    
                </table>
            </fieldset>    
            </td>
        </tr>
    </table>
<!--</form>-->
<gw:textbox id="txtUser_PK" styles="display:none"/>
<gw:textbox id="txtEmp_PK" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>  
<gw:textbox id="txtDept_Pk" styles="display:none"/>
<gw:textbox id="txtGroup_Pk" styles="display:none"/>     
<gw:textbox id="txtApprover_ID" styles="display:none"/>
<gw:textbox id="txtApprover_PK" styles="display:none"/>
<gw:textbox id="txtTmp" styles="display:none"/>
<gw:textbox id="txtEmp_ID" styles="display:none"/>
<gw:textbox id="txtPOS_TYPE" styles="display:none"/>
<gw:textbox id="txtApplicant_PK" styles="display:none"/>
<gw:textbox id="txtStatus" styles="display:none" />
<gw:textbox id="txtThr_Unit_cost_pk" styles="display:none"/>
<gw:datebox id="dtToday" lang="1" styles="display:none"/>
</body>
</html>