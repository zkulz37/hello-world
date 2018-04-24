<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>

var p_pk=0;
var p_dept=1;
var p_section=2;
var p_emp_id=3;
var p_full_name=4;
var p_join_dt=5;

var p_allow_amt1=6;
var p_allow_amt2=7;
var p_allow_amt3=8;
var p_allow_amt4=9;
var p_allow_amt5=10;
var p_allow_amt6=11;
var p_allow_amt7=12;
var p_allow_amt8=13;
var p_allow_amt9=14;
var p_allow_amt10=15;
var p_total=16;
var p_remark=17;
var p_emp_pk=18;
var p_work_month = 19;
var p_tco_org_pk=20;

var v_language = "<%=Session("SESSION_LANG")%>";
var check_init=0;
var tab=0;


function BodyInit()
{
    idGrid.GetGridControl().FrozenCols =4;
    idGrid.GetGridControl().ScrollTrack=true;
    if (v_language!="ENG")
        System.Translate(document);	
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
	idDBUSR.text= "<%=session("APP_DBUSER")%>";
    menu_id.text=System.Menu.GetMenuID();
    
    ChangeColorItem(lstOrg.GetControl());

    datCheck_View.Call();        
}


//----------------------------------
 function ChangeColorItem(lstctl) 
 {
        var slevel1, slevel2, slevel3,slevel4;
        for (var i = 0; i < lstctl.options.length; i++)
        {
            slevel1 = lstctl.options.item(i).text.substr(0, 1);
            slevel2 = lstctl.options.item(i).text.substr(0, 3);
            slevel3 = lstctl.options.item(i).text.substr(0, 5);
            slevel4 = lstctl.options.item(i).text.substr(0, 7);
            if (slevel4 != ".......")
            {
                if(slevel3==".....")
                {
                    lstctl.options.item(i).style.color = "0066CC";
                }
                else  
                {
                    if (slevel2 == "...")
                    {
                        lstctl.options.item(i).style.color = "FF4500";
                    }
                    else
                    {
                        if (slevel1 == ".")
                            lstctl.options.item(i).style.color = "FF00FF";  //FF3333
                    }
                }                
            }
        }
    }

//----------------------------------------------
function OnDataReceive(obj)
{
    if(obj.id == "datCheck_View")
    {
        if(txtFlag_View.text == 'Y')
        {
            ibtnAdd.style.display = "none";
            ibtnSave.style.display = "none";
            ibtndel.style.display = "none";
            idBtnGet.style.display="none";  //tab 2
        }
        if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	    {
            datUser_info.Call();     	    
	    }
        else
        {                       
           changeFromHRCode.Call();
        }
    } 
    else if (obj.id=="datUser_info")  
    {
        ChangeColorItem(lstOrg.GetControl());
	    onChange_org(lstOrg);        
    }
    else if (obj.id=="datWorkGroup_info")
    {
		
		lstWG.SetDataText(txtwg_tmp.text + "|ALL|Select All");
        lstWG.value='ALL';	
        
        changeFromHRCode.Call();
	}
    else if (obj.id=="checkCloseMonth")
    {
		if((txtFlag_View.text == 'N')&&(txtclose_sal_yn.text=='Y'))	
        {
            ibtnAdd.SetEnable(false);
            ibtnSave.SetEnable(false);
            ibtndel.SetEnable(false);
            idRecord2.text="Salary have closed.";
        }
        else
        {   
            if((txtFlag_View.text == 'N')&&(txtclose_sal_yn.text=='N'))
            {
                ibtnAdd.SetEnable(true);
                ibtnSave.SetEnable(true);
                ibtndel.SetEnable(true);
                idRecord2.text="Salary is open."
            }
        } 

        getAdditionAllow.Call();                
	}
    else if (obj.id=="getAdditionAllow")
    {		        
        datAllowance.Call();                      
	}
    else if (obj.id=="datAllowance")
    {
        var grid_row=grdAllowance.rows;       
        if(grid_row>1)
            {
                 var icol=p_allow_amt1; //value of allowance col
                idGrid.SetGridText(0,icol,grdAllowance.GetGridData(1,0));
                idGrid.SetGridText(0,icol+1,grdAllowance.GetGridData(1,1));
                idGrid.SetGridText(0,icol+2,grdAllowance.GetGridData(1,2));
                idGrid.SetGridText(0,icol+3,grdAllowance.GetGridData(1,3));
                idGrid.SetGridText(0,icol+4,grdAllowance.GetGridData(1,4));
                idGrid.SetGridText(0,icol+5,grdAllowance.GetGridData(1,5));
                idGrid.SetGridText(0,icol+6,grdAllowance.GetGridData(1,6));
                idGrid.SetGridText(0,icol+7,grdAllowance.GetGridData(1,7));
                idGrid.SetGridText(0,icol+8,grdAllowance.GetGridData(1,8));
                idGrid.SetGridText(0,icol+9,grdAllowance.GetGridData(1,9));
                idGrid.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,20)));
                idGrid.GetGridControl().ColHidden(icol+1)=!(Number(grdAllowance.GetGridData(1,21)));
                idGrid.GetGridControl().ColHidden(icol+2)=!(Number(grdAllowance.GetGridData(1,22)));
                idGrid.GetGridControl().ColHidden(icol+3)=!(Number(grdAllowance.GetGridData(1,23)));
                idGrid.GetGridControl().ColHidden(icol+4)=!(Number(grdAllowance.GetGridData(1,24)));
                idGrid.GetGridControl().ColHidden(icol+5)=!(Number(grdAllowance.GetGridData(1,25)));
                idGrid.GetGridControl().ColHidden(icol+6)=!(Number(grdAllowance.GetGridData(1,26)));
                idGrid.GetGridControl().ColHidden(icol+7)=!(Number(grdAllowance.GetGridData(1,27)));   
                idGrid.GetGridControl().ColHidden(icol+8)=!(Number(grdAllowance.GetGridData(1,28)));
                idGrid.GetGridControl().ColHidden(icol+9)=!(Number(grdAllowance.GetGridData(1,29)));            
           }       
        else
           {
                idGrid.GetGridControl().ColHidden(icol+0)=1;
                idGrid.GetGridControl().ColHidden(icol+1)=1;
                idGrid.GetGridControl().ColHidden(icol+2)=1;
                idGrid.GetGridControl().ColHidden(icol+3)=1;
                idGrid.GetGridControl().ColHidden(icol+4)=1;
                idGrid.GetGridControl().ColHidden(icol+5)=1;
                idGrid.GetGridControl().ColHidden(icol+6)=1;
                idGrid.GetGridControl().ColHidden(icol+7)=1;   
                idGrid.GetGridControl().ColHidden(icol+8)=1;
                idGrid.GetGridControl().ColHidden(icol+9)=1;              
           }       
       
       //tab 2
                   
      check_init=1;
              
    }	    
    else if (obj.id=="changeFromHRCode")
    {	  
//       alert(txtclose_sal_yn2.text); 
//        alert(txtChangeCode_yn.text);     
        if(txtclose_sal_yn2.text=="Y" || txtChangeCode_yn.text=="N")    
        {
            idBtnGet.SetEnable(0);
        } 
        else
        {
            idBtnGet.SetEnable(1);
        }        
        datAdditionAllow_nm.Call("SELECT");           
	}  
    else if (obj.id=="datAdditionAllow_nm")
    {	                           
         check_init=1;         
	} 
    else if (obj.id=="processFromHRCode")
    {	               
         if(txtProcess.text==1)
         {
            alert("Process successfull.");   
            idBtnGet.SetEnable(0);                   
         } 
         else
         {
            alert("Error occur.");         
         }  
         datAdditionAllow_nm.Call("SELECT");           
	}  
    else if (obj.id=="datAddition_Allow")
    {	                           
         idRecord.text=idGrid.rows-1 + " rec(s).";         
	}  
}

function onChange_org(obj)
{	
	txtorg_tmp.text=obj.value;
	datWorkGroup_info.Call();
	
}

function OnSearch()
{
	if(check_init==1)
    {
		datAddition_Allow.Call("SELECT");
    }
}

function onAdd()
{
	if(check_init==1)
	{
		var fpath = System.RootURL + "/form/ch/cs/chcs00250_AddNew.aspx?";
		var aData=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:60;dialogHeight:30;dialogLeft:270;dialogTop:150;edge:sunken;scroll:yes;unadorned:yes;help:no');
		
		if ( aData != null )
		{ 
         	var len=aData.length;
			var i;
            for (i=0;i<len-1;i++)		
			{
					idGrid.AddRow();
					var irow=idGrid.rows-1;
					aRow=aData[i];
                    
					idGrid.SetGridText(irow,p_dept,aRow[0]);		// Deptpartment
					idGrid.SetGridText(irow,p_section,aRow[1]);		// Section
					idGrid.SetGridText(irow,p_emp_id,aRow[2]);		// Emp ID 
					idGrid.SetGridText(irow,p_full_name,aRow[3]);		// Full Name
					idGrid.SetGridText(irow,p_join_dt,aRow[4]);		// Join Date
					idGrid.SetGridText(irow,p_emp_pk,aRow[5]);	    // _emp_pk              	
					idGrid.SetGridText(irow,p_work_month,dtWorkMonth.value);	 // work month	
                    idGrid.SetGridText(irow,p_tco_org_pk,aRow[6]);  //tco_org_pk
               				
			} 

            if(len>0)
			{
					aRow=aData[len-1];
					lstOrg.value=aRow[0];
					lstWG.value=aRow[1];
					idSearch.value=aRow[2]; //lsttemp
					idtxtTmp.text=aRow[3]; //temp
					lstNation.value=aRow[4];//nation					
             }
        } //if ( aData != null )        
	}	//if(check_init==1)
 }

function OnSave()
{
	if(check_init==1)
		datAddition_Allow.Call();
}
function OnDelete()
{
	if(check_init==1)
	{
		if(confirm("Delete it?\nBạn muốn xóa?"))
			idGrid.DeleteRow();
	}		
}
function onChangeMonth()
{
    checkCloseMonth.Call();
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
function OnSetToGrid(n)
{
    if((txtFlag_View.text == 'N')&&(txtclose_sal_yn.text=='Y'))	
    {
        alert("This month salary have closed.You can't set data.");
        return;
    }
    ctrl=idGrid.GetGridControl();
    var allow_seq=lstAllow.value;    

    if(n==1)//amount
    {        
        if(idAmount.text=="")
            return;
        
        if(idGrid.rows>1)
        {  
            if (ctrl.SelectedRows>1) 
            {
                for(var i=0;i<ctrl.SelectedRows;i++)
                {                       
                    if(idGrid.GetGridData(ctrl.SelectedRow(i),p_allow_amt1 +(allow_seq-1))=="")
                    {
                        idGrid.SetGridText(ctrl.SelectedRow(i),p_allow_amt1 +(allow_seq-1),idAmount.text);                                                                                                                 
                    }                                                                     
                }
            }
            else       
            {
                for(var i=1;i<ctrl.rows;i++)
                {
                    if(idGrid.GetGridData(i,p_allow_amt1 +(allow_seq-1))=="")
                            idGrid.SetGridText(i,p_allow_amt1 +(allow_seq-1),idAmount.text);                               
                }           
            }
        }                       
    }
    else
    {
        if(idRemark.text=="")
            return;
        if(idGrid.rows>1)
        {  
             if (ctrl.SelectedRows>1) 
             {
                   for(var i=0;i<ctrl.SelectedRows;i++)
                       idGrid.SetGridText(ctrl.SelectedRow(i),p_remark,idRemark.text);
             }
             else       
             {
                for(var i=1;i<ctrl.rows;i++)
                {
                    if(idGrid.GetGridData(i,p_remark)=="")
                         idGrid.SetGridText(i,p_remark,idRemark.text);
                 }           
             }
        }
    }
    
}

function OnReport(num)
{
	if(check_init==1)
	{
		
		if(num==1)
		{
			var url = System.RootURL + '/reports/ch/cs/rpt_addition_allowance_template.aspx?p_month=' + dtWorkMonth.value;
		}
		
		window.open(url);
	}	
}

function OnImportNew()
{
    if((txtFlag_View.text == 'N')&&(txtclose_sal_yn.text=='Y'))	
    {
        alert("This month salary have closed.You can't import data.");
        return;
    }
	var currentTime = new Date();		
	txtSequence.text = currentTime.getTime();
   // alert(txtSequence.text);
	
	// argument fixed table_name, procedure, procedure_file
	// dynamic arg p_1,p_2,p_3,p_4,p_5
	var url =System.RootURL + '/system/binary/ReadExcel.aspx?import_seq='+ txtSequence.text +  '&table_name=TES_FILEOBJECT'+  '&procedure=GASP.SP_INSERT_IMAGE' + '&procedure_file='+ idDBUSR.text +'.HR_UPD_ADDITION_ALLOW_EXCELL' + '&p_1=' + dtWorkMonth.value + '&p_2=' + lstOrg.value + '&p_3=' + '&p_4=' + '&p_5=';
	//alert(url);
	txtRecord.text = System.OpenModal(  url , 415, 100 , "unadorned:on ; center:yes; edge:sunken ; resizable:yes;status:yes;" );
	
	if (txtRecord.text != 'undefined')
	{
		alert("Imported : " + txtRecord.text + " record(s)");
	}
    //alert(txtSequence.text);
		
    datImportNew.Call("SELECT");

    
	/*
	var vfilename = document.all["inputfile"].value;
	if (vfilename != '')
	{
		var url = System.RootURL + '/reports/ch/cs/rpt_salary_adj_sample.aspx?p_adj_type='+lstType.value + '&p_file_name='+vfilename;		
		window.open(url);
	}
	else
	{
		alert('Please, input excel file for import !!!');
	}
	*/
}



function onPageActive()
{
	if(tabMain.GetCurrentPageNo()==0)
    {
        tab=1; 
        check_init=0;                
         changeFromHRCode.Call();                       
    }
	if(tabMain.GetCurrentPageNo()==1)
    {
        tab=2; 
        check_init=0;         
        checkCloseMonth.Call();                          
    }
   
}


function OnGetHRCode()
{
    if(confirm("You want to get Addition Allowance from HR Code?"))
    {
        processFromHRCode.Call();
    }
    else
    {
        return;
    }    
}
function onChange_month2()
{
    changeFromHRCode.Call();
}
function onChange_company2()
{
    changeFromHRCode.Call();
}
function onChange_period2()
{
    changeFromHRCode.Call();
}
</script>

<body>
<!-------------------data control----------------------->
<gw:data id="datCheck_View" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="hr_sp_pro_check_view"  > 
                <input>
                    <input bind="iduser_pk" />
                    <input bind="menu_id" />
                </input> 
                <output>
                    <output bind="txtFlag_View" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>

<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_lst_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstOrg" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
<gw:data id="datWorkGroup_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_lst_wg_role"  > 
                <input>
                    <input bind="txtorg_tmp" />
                </input> 
                <output>
                    <output bind="txtwg_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
<gw:data id="checkCloseMonth" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_10030025_check_MonClose" > 
                <input>
                    <input bind="lstOrg" />                    
                    <input bind="dtWorkMonth" />
                    <input bind="txtsal_kind" />
                    <input bind="txtid_sal" />
                </input> 
                <output>
                    <output bind="txtclose_sal_yn" />
                </output>
            </dso> 
        </xml> 
</gw:data>


<gw:data id="datAllowance" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="HR_sp_sel_10030025_allowance" > 
                <input bind="grdAllowance" >                   
                    <input bind="dtWorkMonth" />                                       
                </input>
                <output  bind="grdAllowance" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
<gw:data id="getAdditionAllow" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_lst_10030025_addition_allow"  > 
                <input>   
                    <input bind="dtWorkMonth" />                 
                </input> 
                <output>
                    <output bind="lstAllow" />
                </output>
            </dso> 
        </xml> 
</gw:data>


<gw:data id="datAddition_Allow" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,6,7,8,9,10,11,12,13,14,15,17,18,19,20" function="hr_sel_10030025_addition_allow" procedure="hr_upd_10030025_addition_allow"> 
                <input bind="idGrid" >
                    <input bind="lstOrg" />
                    <input bind="lstWG" />
                    <input bind="idSearch" />
                    <input bind="idtxtTmp" />
                    <input bind="dtWorkMonth" />
                    <input bind="lstPos" />                   
                    <input bind="lstNation" />                    
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datImportNew" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid" function="HR_SEL_ADDITION_ALLOW_IMPORT" > 
                <input bind="idGrid" >
                    <input bind="txtSequence" /> 
                    <input bind="lstOrg" />    
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------>
<gw:data id="changeFromHRCode" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_10030025_check_change" > 
                <input>                                   
                     <input bind="lst_company" />                    
                    <input bind="IDMonth2" />
                    <input bind="lstSal_Period" />                       
                </input> 
                <output>
                    <output bind="txtclose_sal_yn2" />
                    <output bind="txtChangeCode_yn" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------>
<gw:data id="datAdditionAllow_nm" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="" function="hr_sel_10030025_add_allow_nm" procedure=""> 
                <input bind="idGrid2" >                    
                    <input bind="IDMonth2" />                                     
                </input>
                <output  bind="idGrid2" />
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------>
<gw:data id="processFromHRCode" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PROCESS_ALLOW_NM" > 
                <input>
                    <input bind="IDMonth2" />                    
                </input> 
                <output>
                    <output bind="txtProcess" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!--------------------main table--------------------------------->
<gw:tab id="tabMain"  border=1 style="width:100%;height:100%;" onpageactivate="onPageActive()"  >

<table name="Allowance Month" style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
        <tr>
            <td>
	            <table style="width:100%;height:6%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
	                <tr style="height:100%;border:1">	
	                    <td colspan=2 align=right style="width:8%;border:1" >Company</td>
	                    <td colspan=5 align=right style="width:25%;border:1" ><gw:list  id="lst_company" value="ALL" onchange="onChange_company2()" maxlen = "100" styles='width:100%' >
                                        <data><%=ESysLib.SetListDataSQL("SELECT a.pk,A.PARTNER_NAME FROM tco_company a where a.del_if=0 and nvl(a.active_yn,'N')='Y' order by A.PARTNER_ID")%></data></gw:list></td>
							
			           <%-- <td colspan=1 align=right style="width:5%;border:1" >&nbsp;</td>--%>
	        			
            
		    
		                <td colspan=1 align=right style="width:5%;border:1" >Month</td>
		                <td colspan=2 align=right style="width:10%;border:1" ><gw:datebox id="IDMonth2" onchange="onChange_month2()"  maxlen = "10" styles='width:100%'lang="<%=Session("Lang")%>" type=month /></td>
			             <td colspan=1 align=right style="width:8%;border:1" >Sal Period</td>
		                <td colspan=6 align=right style="width:25%;border:1" ><gw:list  id="lstSal_Period" onchange="onChange_period2()" maxlen = "100" styles='width:100%' >
                                        <data><%=ESysLib.SetListDataSQL("SELECT B.CODE,B.CODE_NM||' '|| B.CHAR_1||'->'||B.CHAR_2 FROM VHR_HR_CODE B WHERE B.ID='HR0030'")%></data></gw:list></td>
		     
		                <td colspan=1 align=right style="width:3%;border:1" >&nbsp;</td>
		                <td colspan=1 align=right style="width:5%;border:1" ><gw:icon id="idBtnGet" img="in" text="Confirm from HRCode" onclick="OnGetHRCode()" /></td>
                        
		                <%--<td colspan=1 align=right style="width:4%;border:1" ><gw:icon id="idBtnAdd" img="in" text="Add" onclick="OnAdd()" /></td>
                        
		                <td colspan=1 align=right style="width:4%;border:1" ><gw:icon id="idBtnSave" img="in" text="Save" onclick="OnSave()" /></td>
                        
		                <td colspan=1 align=right style="width:5%;border:1" ><gw:icon id="idBtnDelete" img="in" text="Delete" onclick="OnDelete" /></td>--%>
                    </tr>	
	            </table>
	            <table id="tbl" style="width:100%;height:94%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
		            <tr style="height:100%">
			            <td id="master" width="100%">
				            <gw:grid
					            id="idGrid2"
					            header="pk|Month|Allowance LB|Allowance LB_K|Allowance USE|Allowance Seq|Remark"
					            format="0|0|0|0|0|0|0"
					            aligns="0|1|0|0|1|1|0"
					            defaults="||||||"
					           editcol="0|0|0|0|0|0|0"
					            widths="100|1500|2500|2500|2500|2500|3000|"
					            styles="width:100%;height:100%"
					            sorting="T"					            
					          />
			            </td>
		            </tr>	
	            </table>
           </td>
        </tr>
</table>

<table name="AllowanceEmp Month" style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
	<tr>
	    <td>
	        <table style="width:100%;height:18%" cellpadding="0" cellspacing="0" valign="top" border="0" >	
	            <tr style="height:6%;border:0">	
		            <td align=right colspan=4 style="width:8%" ><a title="Click here to show organization" onclick="OnShowPopup()" href="#tips" >Organization</a></td>
		            <td align=right colspan=10 style="width:18%"><gw:list  id="lstOrg" value="ALL"  maxlen = "100" styles='width:100%' onchange="onChange_org(lstOrg);" >
                            <data>
                                <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                    </td>
		            <td align=right colspan=4 style="width:8%">Work Group</td>
		            <td align=right colspan=10 style="width:18%">
		                <gw:list  id="lstWG" value="ALL" maxlen = "100" styles='width:100%'>
                         <data><%=ESysLib.SetListDataSQL("SELECT A.PK,A.workgroup_nm FROM thr_work_group A WHERE A.DEL_IF=0 ORDER BY a.workgroup_id")%>|ALL|Select All</data></gw:list>
                    </td>
                    <td align=right colspan=3 style="width:6%">Search by</td>
		            <td align=left colspan=4 style="width:8%"><gw:list  id="idSearch" value="1" styles="width:98%" onChange="">
                                            <data>|1|Emp ID|2|Card ID|3|Name</data></gw:list></td>
		            <td align=right colspan=8 style="width:11%"><gw:textbox id="idtxtTmp" maxlen = "50" styles="width:100%" onenterkey="OnSearch()" /></td>		           
		            
                    <td align=left style="width:2%;border:0">
                        
                    </td>
                    
		            <td align=right style="width:3%"><gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch()" /></td>
		            <td align=right style="width:3%"><gw:imgBtn id="ibtnAdd" alt="Add" img="popup" text="Add" onclick="onAdd()" /></td>
		            <td align=right style="width:3%"><gw:imgBtn id="ibtnSave" alt="Save" img="save" text="Save" onclick="OnSave()" /></td>
		            <td align=right style="width:3%"><gw:imgBtn id="ibtndel" alt="Delete" img="delete" text="Delete" onclick="OnDelete()" /></td>
		            <%--<td align=right style="width:3%"><gw:imgBtn id="ibtnRpt1" alt="Report summary" img="excel" text="Report" onclick="OnReport(1)" /></td>
		            <td align=right style="width:3%"><gw:imgBtn id="ibtnRpt1" alt="Report detail" img="excel" text="Report" onclick="OnReport(2)" /></td>	--%>	
                    <td align=right style="width:1%"></td>            		            
                </tr>	
                <tr style="height:6%;border:0">	
		            <td align=right colspan=4>Work Month</td>
		            <td align=left colspan=10><gw:datebox id="dtWorkMonth" type="month" maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" onchange="onChangeMonth()" /></td>		            
		            <td align=right colspan=4>Postion</td>
		            <td align=right colspan=10>
		                <gw:list id="lstPos" value='ALL' styles="width:100%">
				        <data>
				        <%= ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm")%>|ALL|Select All
				        </data>
				        </gw:list>
		            </td>
		            <td align=right colspan=3>Nation</td>
		            <td align=right colspan=4 >
		               <gw:list id="lstNation" value="01"  maxlen = "100" styles='width:100%' >
                        <data>
                            <%=ESysLib.SetListDataSQL("select code, code_nm from vhr_hr_code v where v.ID='HR0009'")%>|ALL|Select All
                        </data>
                        </gw:list>
                    </td>
                    <td align=right colspan=6 style="width:12%"><gw:icon id="idBtnImp" img="in" text="Import Data" onclick="OnImportNew()" /></td>	
                    <td align=right colspan=2 style="width:3%">	<gw:imgBtn id="ibtnSampleRpt" alt="Sample file" img="excel" text="Report" onclick="OnReport(1)" /></b>  </td>          
		            <td align=center colspan=7 style="color:Red;"><gw:label id="idRecord" text="0 rec(s)" styles="width:100%;color:red" ></gw:label>
		            </td>
                </tr>	
                <tr style="height:6%;border:0">	
		            <td align=right colspan=7>
                        <gw:list  id="lstAllow" value="" styles="width:98%" onChange="">
                        </gw:list>
                    </td>
		            <td align=left colspan=6 style="width:16%"><gw:textbox id="idAmount" maxlen = "10" styles="width:100%" onkeypress="return Numbers(event)" onenterkey="OnSetToGrid(1)" /></td>
                    <td align=left style="width:2%"><gw:imgBtn id="ibtnSet1" alt="Set Grid" img="set" text="" onclick="OnSetToGrid(1)" /></td>
		            <td align=right colspan=4>Remark</td>
		            <td align=left colspan=9 style="width:13%"><gw:textbox id="idRemark" maxlen = "100" styles="width:100%"  onenterkey="OnSetToGrid(2)" /></td>
                     <td align=left style="width:2%"><gw:imgBtn id="ibtnSet2" alt="Set Grid" img="set" text="" onclick="OnSetToGrid(2)" /></td>
		            <td align=right colspan=19 align=right><gw:label id="idRecord2" text="" styles="width:100%;color:red" ></gw:label></td>		                                		                    
                </tr>	                                
	        </table>
	        <table id="tblMain" style="width:100%;height:82%" border=1 cellpadding="0" cellspacing="0">
	            <tr style="width:100%;height:100%">
	                <td id="tdMaster" style="width:100%">
	                    <gw:grid   
				        id="idGrid"  
				        header="_pk|Deptpartment|Section|Emp ID|Full Name|Join Date|Allowance AMT1|Allowance AMT2|Allowance AMT3|Allowance AMT4|Allowance AMT5|Allowance AMT6|Allowance AMT7|Allowance AMT8|Allowance AMT9|Allowance AMT10|Total|Remark|_emp_pk|_work_month|_tco_org_pk"                           
				        format="0|0|0|0|0|0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|0|0|0|0"  
				        aligns="0|0|0|1|0|1|1|1|1|1|1|1|1|1|1|1|1|0|0|1|0"  
				        defaults="||||||||||||||||||||"  
				       editcol="0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|0|1|0|0|0"  
				        widths="0|2500|2500|1500|3000|1500|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|1500|2000|0|1500|0"  
				        styles="width:100%; height:100% "   
				        sorting="T" 				          
				        oncellclick     = ""/>
	                </td>
	            </tr>
	        </table>
	    </td>
	</tr>
</table>
</gw:tab>

<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="idDBUSR" text="" styles="display:none"  />
<gw:textbox id="menu_id" text="" styles="display:none"  />
<gw:textbox id="txtFlag_View" text="" styles="display:none"  />
<gw:textbox id="txtorg_tmp" styles="display:none"/>
<gw:textbox id="txtwg_tmp" styles="display:none"/> 
<gw:textbox id="txtclose_sal_yn" styles="display:none"/>
<gw:textbox id="txtsal_kind" text="1"styles="display:none"/> 
<gw:textbox id="txtid_sal" text="01" styles="display:none"/>\
<gw:textbox id="txtSequence" text="" styles="display:none"  />
<gw:textbox id="txtRecord" text="" styles="display:none"  />

<gw:textbox id="txtclose_sal_yn2" styles="display:none"/>
<gw:textbox id="txtChangeCode_yn" styles="display:none"/>
<gw:textbox id="txtProcess" styles="display:none"/>


<gw:grid   
    id="grdAllowance"  
    header="Code FName 1|Code FName 2|Code FName 3|Code FName 4|Code FName 5|Code FName 6|Code FName 7|Code FName 8|Code FName 9|Code FName 10|Code KName 1|Code KName 2|Code KName 3|Code KName 4|Code KName 5|Code KName 6|Code KName 7|Code KName 8|Code KName 9|Code KName 10|Display 1|Display 2|Display 3|Display 4|Display 5|Display 6|Display 7|Display 8|Display 9|Display 10"
    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
    aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
    defaults="|||||||||||||||||||||||||||||"  
   editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
    widths="1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500"  
    styles="display:none" 
    sorting="T"    
/> 

</body>
</html>

