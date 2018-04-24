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
var obj_list_code; //temp list of common code list



var v_language = "<%=Session("SESSION_LANG")%>";
var lang= "<%=Session("Lang")%>"; 
var dept_pk = "<%=Session("ORG_PK")%>"; 
var iSelect             = 0,
    iApplicantID        = 1,
    iEmpID              = 2,
    iFullName           = 3,
    iDepartment         = 4,
    iGroup              = 5,
    iCardType           = 6,    
    iQuantity           = 7,
    iAmount             = 8,
    iSubmittedDate      = 9,
    iStatus_NM          = 10,
    iRemaining          = 11,
    iTotalBudget        = 12,
    iApproveLevel_NM    = 13,
    iBizPK              = 14,
    iEmp_pk             = 15,
    iRemark             = 16,
    iManagerRespon      = 17,
    iGAManagerRespon    = 18,
    iApproveLevel       = 19,
    iStatus             = 20;
    

function BodyInit()
{          
        
    if (v_language!="ENG")
        System.Translate(document);
        
     iduser_pk.text = "<%=session("USER_PK")%>";
     txtHr_level.text= "<%=session("HR_LEVEL")%>";
     txtManager_PK.text="<%=session("EMPLOYEE_PK")%>";
     txtUser_ID.text="<%=session("USER_ID")%>"; 
     
     BindingDataList();
     
    // 01 : manager , 02: ga 

    
    // status of buttons
        icnApprove.SetEnable(false);
        icnReject.SetEnable(false);
        icnRequest.SetEnable(false);
    var l_today = dtSubmit_Dt_To.value;
    var l_year = l_today.substring(0, 4);
    dtSubmit_Dt_Fr.value = l_year + '0101';      
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
/*-----------------------*/

function BindingDataList()
{   
     lstDept.SetDataText("<%=ESysLib.SetListDataSQL("select pk, org_nm from comm.tco_org a where nvl(a.leaf_yn,'Y')='N' and del_if=0")%>|ALL|Select All");
     lstDept.value = dept_pk;
     dso_approver_info.Call();
     // trang thai cua cac nut
     icnApprove.SetEnable(false);
     icnReject.SetEnable(false);
     icnRequest.SetEnable(false);
     ibtnRegis_Res.SetEnable(false);
}
//-----------------------------------------------
function OnExpand()
{
    for (var i=1; i<=3;i++)
    {
        var temp;
        temp="h" + i;
        var coll= document.all(temp);
        coll.style.display=""
        var maintab=document.all("main");
        maintab.style.height="90%";
    }        
}

//-----------------------------------------------
function OnShowPopup(strtemp,objlist)
{
    if (strtemp==1 )
    {
        
        var strcom
        var fpath = System.RootURL + "/form/ch/ae/chae00010_emp_id_code.aspx?maxid=" + lblMaxID.text ;
        var obj  = System.OpenModal(  fpath , 900 , 450 , 'resizable:yes;status:yes');
    
    }
    else if (strtemp==2)
    {
        var strcom;
        var fpath = System.RootURL + "/form/ch/ae/chae00010_dept.aspx?";
        //var obj  = System.OpenModal(  fpath , 300 , 200 , 'resizable:yes;status:yes');
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:330;edge:sunken;scroll:no;unadorned:yes;help:no');
        if (obj!=null)
        {
            txtUpperDept.text=obj;
            datDeptData.Call();            
        }
    }
    else
    {
        var strcom;
        obj_list_code=objlist;
        var fpath = System.RootURL + "/form/ch/ae/chae00010_com_code.aspx?code=" +  strtemp ;
        var strid = strtemp;
        
	    var obj  = System.OpenModal(  fpath , 800 , 600 , 'resizable:yes;status:yes');
	    if (obj!=null)
	    {
	        strcodereturn=obj[1];
	        txtComCodeID.text= strtemp;
	        if (obj[0]==1 )  //modify common code
	            datGetNewCode.Call("SELECT");
	        
	        else if (strcodereturn!=0)
	        {
	            
                obj_list_code.value=strcodereturn;
	        }	        
	    }
    }    
}
//----------------------------------------------
function OnSearch()
{    
    txtTemp_PK.text="";
    //txtaResponse_L1.text="";
    txtaResponse_L2.text="";
    datApproval_Biz_Card.Call("SELECT");
}

function OnApprove(objaction)
{
    var i ;
    var l_chk = '', l_status = '', l_approve_level = '', n = 0;
     for( i = 1; i < grdEmployee.rows; i++)
     {
        l_chk = grdEmployee.GetGridData(i, iSelect);
        if(l_chk == '-1')
        {
            l_status = grdEmployee.GetGridData(i, iStatus);
            l_approve_level = grdEmployee.GetGridData(i, iApproveLevel);
            if( !(l_status == '40' && l_approve_level == '01') )
            {
                if(objaction == '1')
                {
                    alert('Please choose the Approved (Manager) to approve at row ' + i);
                    return ;
                }                    
                else if(objaction == '2')
                {
                    alert('Please choose the Approved (Manager) status to reject at row ' + i);
                    return ;                
                }
                else if(objaction == '3')
                {
                    alert('Please choose the Approved (Manager) status to request more information at row ' + i);
                    return ;                                
                }
            }
            else if(objaction == '2' || objaction == '3') //Reject or Request more information
            {
                if(Trim(txtaResponse_L2.GetData()) == "")
                {
                    alert('Please input response...');
                    txtaResponse_L2.GetControl().focus();
                    return ;
                }
            }            
        }
     }
    if(objaction == '1')
        lstStatus.value = '40';
    else if(objaction == '2')
        lstStatus.value = '50';                
    else if(objaction == '3')        
        lstStatus.value = '60';                
    for( i = 1; i < grdEmployee.rows; i++)
    {
        lchk = grdEmployee.GetGridData(i, iSelect);
        if(lchk == '-1')
        {
            if(objaction == '1')
                grdEmployee.SetGridText(i, iStatus, '40');            
            else if(objaction == '2')                
            {
                grdEmployee.SetGridText(i, iStatus, '50'); // Reject            
                grdEmployee.SetGridText(i, iGAManagerRespon, Trim(txtaResponse_L2.GetData()) );            
            }                
            else if( objaction == '3')               
            {
                grdEmployee.SetGridText(i, iStatus, '60'); // Request more information
                grdEmployee.SetGridText(i, iGAManagerRespon, Trim(txtaResponse_L2.GetData()) );
            }                
            n += 1;
        }
        else
            grdEmployee.SetRowStatus(i, 0);
    }
    if(n > 0)
        datApproval_Biz_Card.Call();    
    
}

function OnRegis_Res()
{
    var i, lcheck = '', n = 0 ;
    var iapp_level;
    for(i = 1; i < grdEmployee.rows; i++)
    {
        lcheck = grdEmployee.GetGridData(i, iSelect);
        if(lcheck == '-1')
        {
            grdEmployee.SetGridText(i, iGAManagerRespon, Trim(txtaResponse_L2.GetData()) );
            n += 1;
        }
        else
            grdEmployee.SetRowStatus(i, 0);
    }
    if(n > 0)
    {
        datApproval_Biz_Card.Call();
    }                      
}
function OnSelect()
{
/* hien thong tin response */
    var lrow=event.row;
    var lcol=event.col;    
    
    if (lrow >= 1)
    {
        txtaResponse_L2.SetDataText( grdEmployee.GetGridData(lrow, iGAManagerRespon) );
    }
}
//------------------------------------------------------------------------------------
function OnChangeDept()
{
    
}
function OnDataReceive(obj)
{
       if (obj.id=="datUser_info") //
       {
           
       } 
       else if (obj.id=="datGroupData")
       {
       }
       else if (obj.id=="datApproval_Biz_Card")
	   {
	        lblRecord.text=grdEmployee.rows-1 + " record(s)";	  
	        if (grdEmployee.rows>1)
	            grdEmployee.SetCellBgColor(1,iStatus,grdEmployee.rows -1 ,iStatus,0xCC99FF);
	        auto_resize_column(grdEmployee,0,grdEmployee.cols-1,9); 
	        ibtnRegis_Res.SetEnable(false);
	        icnApprove.SetEnable(false);
	        icnReject.SetEnable(false);
	        icnRequest.SetEnable(false);
	        
	    }
	    else if (obj.id=="datProApproval")
	    {
	        if (txtResult.text=="1")
	        {
	            alert("This action is sucessful!");
    	        grdEmployee.SetGridText(irow,iManagerRespon,txtRespon_L1.GetData());
    	        grdEmployee.SetGridText(irow,iGAManagerRespon,txtRespon_L2.GetData());
    	        
	            grdEmployee.SetGridText(irow,iStatus,txtStatus.text);
	            grdEmployee.SetGridText(irow,iStatus_NM,txtStatus_NM.text);	            	           
	            grdEmployee.SetGridText(irow,iApproveLevel,txtApprove_Level.text);
	            grdEmployee.SetGridText(irow,iApproveLevel_NM,txtApp_Level_NM.text);
	            
	        }
	        else
	            alert("This action is failed!");
	    }
		else if(obj.id == "dso_approver_info")
		{			
			txtManagerLevel.text = txtManager_KIND.text;
		}
}       
function OnDataError(oData)
{
  //alert(eval(oData).errmsg);
    if (eval(oData).errno == 20001)
    {
		alert("Database problem 1: "+ eval(oData).errmsg);
    }
    else if (eval(oData).errno == 20002)
    {
		alert("Database problem 2: "+ eval(oData).errmsg);
    }
	else if (eval(oData).errno > 0)
	{
		alert("Unexpected error: "+ eval(oData).errmsg);
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

function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}

function OnCheck()
{
    var lrow = event.row ;
    var lcol = event.col ;
    var l_check = '', l_status = '', l_approve_level = '';
    if(lcol == iSelect)
    {
        l_check = grdEmployee.GetGridData(lrow, iSelect);
        if(l_check == '-1')
        {
            l_status = grdEmployee.GetGridData(lrow, iStatus);
            l_approve_level = grdEmployee.GetGridData(lrow, iApproveLevel);
            if(l_status == '40') //Approve 
            {
                if(l_approve_level == '01') // phai la approved manager
                {
                    ibtnRegis_Res.SetEnable(true);
                    icnApprove.SetEnable(true);
                    icnReject.SetEnable(true);
                    icnRequest.SetEnable(true);
                }
                else
                {
                    ibtnRegis_Res.SetEnable(false);
                    icnApprove.SetEnable(false);
                    icnReject.SetEnable(false);
                    icnRequest.SetEnable(false);                            
                }                                    
            }
            else
            {
                ibtnRegis_Res.SetEnable(false);
                icnApprove.SetEnable(false);
                icnReject.SetEnable(false);
                icnRequest.SetEnable(false);            
            }
        }
    }
}

</script>


<body bgcolor='#F5F8FF'>

<!--------------------------------------------->
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr.sp_sel_user_role2"  > 
                <input>
                    <input bind="txtManager_PK" />
                </input> 
                <output>
                    <output bind="lstDept" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!----------------------------------->
<gw:data id="datApproval_Biz_Card" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="grid" function="hr.sp_sel_approval_biz_card_ga" parameter="14,18,20" procedure="hr.sp_upd_approval_biz_card_ga" > 
            <input> 
                <input bind="lstDept" />                 
                <input bind="lstStatus" />   
                <input bind="chkTemp" /> 
                <input bind="txtTemp" />                 
                <input bind="dtSubmit_Dt_Fr" /> 
                <input bind="dtSubmit_Dt_To" />
                <input bind="txtManagerLevel" />
            </input> 
            <output bind="grdEmployee" /> 
        </dso> 
   </xml> 
</gw:data> 
<!----------------------------------->
<gw:data id="datProApproval" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_approval_bcard" > 
                <input>                    
                   <input bind="txtBiz_Card_PK" />                   
                   <input bind="txtaResponse_L2" />
                   <input bind="txtAction" />
                   <input bind="txtManagerLevel" />
                </input> 
                <output>    
                    <output bind="txtStatus" />
                    <output bind="txtResult" />
                    <output bind="txtApprove_Level" />
                    <output bind="txtApp_Level_NM" />
                    <output bind="txtStatus_NM" />
                    <output bind="txtRespon_L1" />
                    <output bind="txtRespon_L2" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="dso_approver_info" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_get_biz_empid" > 
                <input>                    
                   <input bind="txtManager_PK" />
                </input> 
                <output>    
                    <output bind="txtEmployee_ID" />
                    <output bind="txtEmployee_NM" />
                    <output bind="txtManager_ID" />
                    <output bind="txtManager_NM" />
                    <output bind="txtManager_KIND" />
                    <output bind="txtManager_DEPT" />
                    <output bind="txtApplication_LV" />
                    <output bind="txtPK_Manager" />
                    <output bind="txtCompany_PK" />
                    <output bind="txtTacABPLCenter_PK" />
                    <output bind="txtPLNM" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!---------------------main employee tab data control------------------>

<table style='margin-left:10px' align = top  cellspacing=0 cellpadding=0 border=1 style="width:100%;height:100%;" >
	<tr style="height:10%"> 
	    <td  align = top colspan=2>
		    <table align = top  width="100%" CELLSPACING="0" CELLPADDING="0" >
		        <tr>
			        <td align="Left">
				        <table   border="0" CELLSPACING="0" CELLPADDING="0" style="height:inherit" >
					        <tr>   
						        <td width="10%" align="right"><font color="black"><b >Department</b></td>
						        <td width="15%"><gw:list id="lstDept" styles="color:black;width:100%" value="ALL" onchange="OnChangeDept()"></gw:list ></td>
						        <td width="10%" align="right"><font color="black"><b ></b></td>
						        <td width="15%"></td>
						        <td width="10%" align="right"><font color="black"><b >Employee</b></td>
						        <td width="10%" align="left" ><gw:list  id="chkTemp" value="2" styles='width:100%' onchange=""> 
                                    <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Per ID</data></gw:list></td>
							    <td colspan=3 align=right><gw:textbox id="txtTemp" onenterkey   ="OnSearch()" styles='width:100%'/></td>
							    <td width="10%">&nbsp;</td>
							    <td width="3%" align="right"><gw:imgBtn id="ibtnSearch" alt="Search" img="Search" text="Search" onclick="OnSearch()" /></td>
							    <td width="3%" align="right">
							       <gw:icon id="ibtnRegis_Res" text="Save Response" onclick="OnRegis_Res()" />
						        </td>
							    <td>
									<table>
										<tr>
											<td align = "right"  width="80%" ><gw:icon id="icnApprove" img="in" text="Approve" onclick="OnApprove(1)" /></td>
											<td align = "center" width="10%" ><gw:icon id="icnReject" img="in" text="Reject" onclick="OnApprove(2)" /></td>
											<td align = "right"  width="10%" ><gw:icon id="icnRequest" img="in" text="Request Infor" onclick="OnApprove(3)" /></td>
										</tr>
									</table>
								</td>
                            </tr>
                            <tr>						    
						        <td align="right"><font color="black"><b >Status</b></td>						        
						        <td ><gw:list  id="lstStatus" value="40" styles='width:100%' onchange="OnSearch()"><data>
                                    <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0079' and code not in('10','20','30', '130') order by code_nm")%></data></gw:list></td>
                                <td >&nbsp;</td>
                                <td >&nbsp;</td>
                                <td width="10%" align="right"><font color="black"><b >Submitted date</b></td>
                                <td width="10%" ><gw:datebox id="dtSubmit_Dt_Fr" styles='width:100%' lang="<%=Session("Lang")%>" /></td>
                                <td width="2%" align=center>&nbsp; ~ </td>
							    <td width="10%" ><gw:datebox id="dtSubmit_Dt_To" styles='width:100%' lang="<%=Session("Lang")%>"  /></td>
							    <td >&nbsp;</td>
							    <td colspan=2 align="center"><i><gw:label id="lblRecord" text="0 record(s)" styles="width:100%" ></gw:label></i></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr align = top style="height:80%" > 
        <td  id="tblMaster"  width=100% >
            <table id="idGrid" align = top  width="100%" style="height:70%" CELLSPACING="0" CELLPADDING="0">
                <tr align = top style="height:100%"> 
	                <td colspan=3 align = top  width="100%"  >
  		                <gw:grid   
			                id="grdEmployee"  
                                header  ='Select|Applicant ID|Emp ID|Full Name|Department|Group|Card Type|Quantity|Amount|Submitted Date|Status|Remaining|Total Budget|Approve Level|_PK|_Emp_pk|Description|Manager Respon|_GA Manager Respon|_Approve Level|_Status'
                                format  ='3|0|0|0|0|0|0|1|1|0|0|1|1|0|0|0|0|0|0|0'
                                aligns  ='1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                defaults='||||||||||||||||||||'
                                editcol ='3|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                widths  ='1000|2000|1000|2000|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|0|0|0|0|0|0|0'
                                sorting ='T'
                                oncellclick ="OnSelect()" 
                                onafteredit ="OnCheck()" 
                                styles='width:100%; height:100%'
                                />
  	                </td>
                </tr>
            </table>
            <table id="idRes" align = top  width="100%" style="height:30%" CELLSPACING="0" CELLPADDING="0">
                <tr id="idRes_NM_L2" style="height:10%;">
                    <td colspan=3 align = top  width="100%">Response</td>
                </tr>
                <tr id="idRes_L2" style="height:35%;">
                    <td colspan=3  align = top   width="100%"  >
  		                <gw:textarea id="txtaResponse_L2" text="2222"  styles="width:100%;height:96%;font-size:15"/>
  	                </td>
                </tr>
            </table>
            
        </td>
    </tr>
</table>

<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="txtManager_PK" styles="display:none"/>
<gw:textbox id="txtUser_ID" styles="display:none"/>

<gw:textbox id="txtGroupData" styles="display:none"/>
<gw:textbox id="txtTemp_PK" styles="display:none"/>
<gw:textbox id="txtBiz_Card_PK" styles="display:none"/>
<gw:textbox id="txtStatus" styles="display:none"/>
<gw:textbox id="txtStatus_NM" styles="display:none"/>
<gw:textbox id="txtManagerLevel" styles="display:none"/>
<gw:textbox id="txtAction" styles="display:none"/>
<gw:textbox id="txtResult" text="0" styles="display:none"/>
<gw:textbox id="txtApprove_Level" text="0" styles="display:none"/>
<gw:textbox id="txtApp_Level_NM" text="0" styles="display:none"/>
<gw:textbox id="txtRespon_L1" text="0" styles="display:none"/>
<gw:textbox id="txtRespon_L2" text="0" styles="display:none"/>
<gw:textbox id="txtStatus_Text" text="0" styles="display:none"/>
<!--Thong tin manager cua user log in vao-->
<gw:textbox id="txtEmployee_ID" text="0" styles="display:none" />
<gw:textbox id="txtEmployee_NM" text="0" styles="display:none" />
<gw:textbox id="txtManager_ID" text="0" styles="display:none" />
<gw:textbox id="txtManager_NM" text="0" styles="display:none" />
<gw:textbox id="txtManager_KIND" text="0" styles="display:none" />
<gw:textbox id="txtManager_DEPT" text="0" styles="display:none" />
<gw:textbox id="txtApplication_LV" text="0" styles="display:none" />
<gw:textbox id="txtPK_Manager" text="0" styles="display:none" />
<gw:textbox id="txtCompany_PK" text="0" styles="display:none" />
<gw:textbox id="txtTacABPLCenter_PK" styles="display:none" />
<gw:textbox id="txtPLNM" styles="display:none" />
                    

</body>



