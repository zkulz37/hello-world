<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var check_init=0;
var dept,grp,flag=0;
var flag_wg=1;
var flag_tab=1;
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    idGrid.GetGridControl().ScrollTrack=true;
    if (v_language!="ENG")
        System.Translate(document);	
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
	idDBUSR.text= "<%=session("APP_DBUSER")%>";
    menu_id.text=System.Menu.GetMenuID();

    <%=ESysLib.SetGridColumnComboFormat( "idGrid" , 4 , "select CODE,CODE_NM from VHR_HR_CODE WHERE ID='HR0034' ORDER BY CODE") %>;    
    <%=ESysLib.SetGridColumnComboFormat( "idGrid" , 6 , "select CODE,CODE_NM from VHR_HR_CODE WHERE ID='HR0040' ORDER BY CODE") %>;  
    <%=ESysLib.SetGridColumnComboFormatString2( "idGrid" , 7 , "Y|YES|N|NO") %>; 
    
    idTotalVND.SetEnable(0); 
    
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

                ibtnProcess.style.display = "none";
                ibtnSaveImport.style.display = "none";
            }
            if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	        {
                datUser_info.Call();     	    
	        }
            check_init=1;
       }
    else if (obj.id=="datSalary_Adjust")
       {            
			_TotalLabel();			
       }
	else if (obj.id=="datUser_info")  
	{
		onChange_org(1,lstOrg);
        check_init=1;
	}
	else if (obj.id=="datWorkGroup_info")
   {
		
		lstWG.SetDataText(txtwg_tmp.text + "|ALL|Select All");
        lstWG.value='ALL';
		check_init=1;
	}	
	
	   

}      
function onChange_org(tab,obj)
{
	flag_tab=tab;
	txtorg_tmp.text=obj.value;
	datWorkGroup_info.Call();
	
}
function _TotalLabel()
{
	var _sumVND=0, _sumUSD=0;
	for(var i=1;i<idGrid.rows;i++)
	{
		if(idGrid.GetGridData(i,6)=="01")
			_sumVND += Number(idGrid.GetGridData(i,5));
		else
			_sumUSD += Number(idGrid.GetGridData(i,5));
	}
	idTotalVND.text= _sumVND  ;
	idTotalUSD.text= _sumUSD  ;
	idRecord.text=idGrid.rows-1 + " rec(s).";
}
function OnShowPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:25;dialogHeight:25;dialogLeft:10;dialogTop:240;edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        lstOrg.value=obj
		onChange_org(1,lstOrg);
       
    }
    
}
function OnSearch()
{
	if(check_init==1)
		datSalary_Adjust.Call("SELECT");
}
function onAdd()
{
	if(check_init==1)
	{
		if(lstType.value=="ALL")
		{
			alert("You must choose type.\nBạn phải chọn kiểu adjust")
			return;
		}
		var fpath = System.RootURL + "/form/ch/cs/chcs00050_AddNew.aspx?";
		var aData=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:60;dialogHeight:30;dialogLeft:80;dialogTop:150;edge:sunken;scroll:yes;unadorned:yes;help:no');
		
		if ( aData != null )
		{  	 
			var len=aData.length;
			var i;
			for (i=0;i<len-1;i++)		
			{
					idGrid.AddRow();
					var irow=idGrid.rows-1;
					aRow=aData[i];
					idGrid.SetGridText(irow,0,aRow[0]);		// group
					idGrid.SetGridText(irow,1,aRow[1]);		// emp id
					idGrid.SetGridText(irow,2,aRow[2]);		// name 
					idGrid.SetGridText(irow,3,aRow[3]);		// dt
					idGrid.SetGridText(irow,4,lstType.value);		// adj type
					idGrid.SetGridText(irow,6,'01');		
					idGrid.SetGridText(irow,7,'Y');		
					idGrid.SetGridText(irow,9,aRow[4]);		// emp_pk
			}
			if(len>0)
			{
					aRow=aData[len-1];
					dept=aRow[0];
					grp=aRow[1];
					idSearch.value=aRow[2]; //lsttemp
					idtxtTmp.text=aRow[3]; //temp
					FromDT.value=aRow[4];//from dt
					ToDT.value=aRow[4];//to date
				if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
				{
					  flag=1;
					  datUser_info.Call();
				}      
				else
				{
					
					lstOrg.SetDataText("<%= ESysLib.SetListDataSQL("select pk,org_nm from tco_org a where del_if=0 order by a.seq ")%>" + '|ALL|Select All');    
					lstWG.SetDataText("<%= ESysLib.SetListDataSQL("SELECT pk,workGroup_NM FROM Thr_work_Group WHERE DEL_IF = 0 order by workGroup_NM")%>" + '|ALL|Select All');
					lstOrg.value=aRow[0]; //dept
					lstWG.value=aRow[1]; //grp
				   
				}
			 }   
		}	
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
function OnSetToGrid(n)
{
    ctrl=idGrid.GetGridControl();
    if(n==1)//amount
    {
        if(idAmount.text=="")
            return;
        if(idGrid.rows>1)
        {  
             if (ctrl.SelectedRows>1) 
             {
                   for(var i=0;i<ctrl.SelectedRows;i++)
                       idGrid.SetGridText(ctrl.SelectedRow(i),5,idAmount.text);
             }
             else       
             {
                for(var i=1;i<ctrl.rows;i++)
                {
                    if(idGrid.GetGridData(i,5)=="")
                         idGrid.SetGridText(i,5,idAmount.text);
                }           
             }
         }
    }
    else
    {
        if(idNote.text=="")
            return;
        if(idGrid.rows>1)
        {  
             if (ctrl.SelectedRows>1) 
             {
                   for(var i=0;i<ctrl.SelectedRows;i++)
                       idGrid.SetGridText(ctrl.SelectedRow(i),8,idNote.text);
             }
             else       
             {
                for(var i=1;i<ctrl.rows;i++)
                {
                    if(idGrid.GetGridData(i,8)=="")
                         idGrid.SetGridText(i,8,idNote.text);
                 }           
             }
        }
    }
    
}
function OnSave()
{
	if(check_init==1)
		datSalary_Adjust.Call();
}
function OnDelete()
{
	if(check_init==1)
	{
		if(confirm("Delete it?\nBạn muốn xóa?"))
			idGrid.DeleteRow();
	}		
}
function OnReport(num)
{
	if(check_init==1)
	{
		if(num==2)
		{
			var url =System.RootURL + '/reports/ch/cs/rpt_salary_adjustment.aspx?p_from='+FromDT.value+'&p_to='+ToDT.value+'&p_adj_type='+lstType.value+'&org_type='+lstWG.value+'&p_tco_org_pk='+lstOrg.value+'&p_search_by='+idSearch.value+'&p_search_temp='+idtxtTmp.text+'&p_nation='+lstNation.value;        
		}
		if(num==1)
		{
			var url = System.RootURL + '/reports/ch/cs/rpt_adjust_salary_template.aspx' ;
		}
		if(num==3)
		{
			var url = System.RootURL + '/reports/ch/cs/rpt_salary_adjustment_summary.aspx?p_from='+FromDT.value+'&p_to='+ToDT.value+'&p_adj_type='+lstType.value+'&org_type='+lstWG.value+'&p_tco_org_pk='+lstOrg.value+'&p_search_by='+idSearch.value+'&p_search_temp='+idtxtTmp.text+'&p_nation='+lstNation.value;        
		}
		window.open(url);
	}	
}

function OnImportNew()
{
	var currentTime = new Date();		
	txtSequence.text = currentTime.getTime();
	var p_cols;
   // alert(txtSequence.text);
	
	// argument fixed table_name, procedure, procedure_file
	// dynamic arg p_1,p_2,p_3,p_4,p_5
	if (lstType.value == 'ALL')
	{
		alert('Please, select adjust type !!!');
		return;
	}
	p_cols=7;
	var url =System.RootURL + '/system/binary/ReadExcel.aspx?import_seq='+ txtSequence.text + '&p_err_cont=Y' + '&table_name=TES_FILEOBJECT'+  '&procedure=GASP.SP_INSERT_IMAGE' + '&procedure_file='+ idDBUSR.text +'.HR_UPD_ADJUST_SALARY_EXCELL' + '&p_cols='+ p_cols + '&p_1=' + lstType.value + '&p_2=' + '&p_3=' + '&p_4=' + '&p_5=';
	//alert(url);
	txtRecord.text = System.OpenModal(  url , 415, 100 , "unadorned:on ; center:yes; edge:sunken ; resizable:yes;status:yes;" );
	
	if (txtRecord.text != 'undefined')
	{
		alert("Imported : " + txtRecord.text + " record(s)");
	}
		
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





</script>

<body>
<gw:data id="datCheck_View" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="sp_pro_check_view"  > 
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
<!------------main control---------------------->
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

<gw:data id="datSalary_Adjust" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="2,3,4,5,6,7,8,9,10" function="hr_sel_10030005_salary_adjust" procedure="hr_upd_10030005_salary_adjust"> 
                <input bind="idGrid" >
                    <input bind="lstOrg" />
                    <input bind="lstWG" />
                    <input bind="lstType" />
                    <input bind="FromDT" />
                    <input bind="ToDT" />
                    <input bind="idSearch" />
                    <input bind="idtxtTmp" />
                    <input bind="lstNation" />
                    
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datImportNew" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid" function="HR_SEL_SALARY_ADJUST_IMPORT" > 
                <input bind="idGrid" >
                    <input bind="txtSequence" />    
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
</gw:data>



<!--------------------main table--------------------------------->
<table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
	<tr>
	    <td>
	        <table style="width:100%;height:18%" cellpadding="0" cellspacing="0" valign="top" border="0" >	
	            <tr style="height:6%;border:0">	
		            <td align=right colspan=4 style="width:8%" ><a title="Click here to show organization" onclick="OnShowPopup()" href="#tips" >Organization</a></td>
		            <td align=right colspan=10 style="width:20%"><gw:list  id="lstOrg" value="ALL"  maxlen = "100" styles='width:100%' onchange="onChange_org(1,lstOrg);" >
                            <data>
                                <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                    </td>
		            <td align=right colspan=5 style="width:10%">Work Group</td>
		            <td align=right colspan=6 style="width:12%">
		                <gw:list  id="lstWG" value="ALL" maxlen = "100" styles='width:100%'>
                         <data><%=ESysLib.SetListDataSQL("SELECT A.PK,A.workgroup_nm FROM thr_work_group A WHERE A.DEL_IF=0 ORDER BY a.workgroup_id")%>|ALL|Select All</data></gw:list>
                    </td>
                    <td align=right colspan=3 style="width:6%">Search by</td>
		            <td align=left colspan=4 style="width:8%"><gw:list  id="idSearch" value="1" styles="width:98%" onChange="">
                                            <data>|1|Emp ID|2|Card ID|3|Name</data></gw:list></td>
		            <td align=right colspan=3 style="width:6%"><gw:textbox id="idtxtTmp" maxlen = "50" styles="width:100%" onenterkey="OnSearch()" /></td>
		            <td align=right colspan=3 style="width:6%">Nation</td>
		            <td align=right colspan=5 style="width:10%"><gw:list id="lstNation" value="01"  maxlen = "100" styles='width:100%' >
                        <data>
                            <%=ESysLib.SetListDataSQL("select code, code_nm from vhr_hr_code v where v.ID='HR0009'")%>|ALL|Select All
                        </data>
                        </gw:list>
                    </td>
                    <td align=left style="width:2%;border:0">
                        
                    </td>
                    
		            <td align=right style="width:2%"><gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch()" /></td>
		            <td align=right style="width:2%"><gw:imgBtn id="ibtnAdd" alt="Add" img="popup" text="Add" onclick="onAdd()" /></td>
		            <td align=right style="width:2%"><gw:imgBtn id="ibtnSave" alt="Save" img="save" text="Save" onclick="OnSave()" /></td>
		            <td align=right style="width:2%"><gw:imgBtn id="ibtndel" alt="Delete" img="delete" text="Delete" onclick="OnDelete()" /></td>
		            <td align=right style="width:2%"><gw:imgBtn id="ibtnRpt2" alt="Report summary" img="excel" text="Report" onclick="OnReport(3)" /></td>
		            <td align=right style="width:2%"><gw:imgBtn id="ibtnRpt" alt="Report detail" img="excel" text="Report" onclick="OnReport(2)" /></td>		            		            
                </tr>	
                <tr style="height:6%;border:0">	
		            <td align=right colspan=4>From</td>
		            <td align=left colspan=4><gw:datebox id="FromDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		            <td align=right colspan=2>To</td>
		            <td align=left colspan=4 ><gw:datebox id="ToDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		            <td align=right colspan=5>Type</td>
		            <td align=right colspan=6>
		                <gw:list id="lstType" value='01' styles="width:100%">
				        <data>
				        <%=ESysLib.SetListDataSQL("SELECT CODE,CODE_NM FROM VHR_HR_CODE WHERE ID='HR0034' ORDER BY CODE")%>|ALL|Select All
				        </data>
				        </gw:list>
		            </td>
		            <td align=right colspan=3>Amount</td>
		            <td align=right colspan=5 >
		                <gw:textbox id="idAmount" maxlen = "10" styles="width:100%" onkeypress="return Numbers(event)" onenterkey="OnSetToGrid(1)" />
                    </td>
                    <td align=center><gw:imgBtn id="ibtnSet1" alt="Set Grid" img="set" text="" onclick="OnSetToGrid(1)" /></td>
		            <td align=right colspan=4 style="width:5%">Note</td>
		            <td align=left colspan=7><gw:textbox id="idNote" maxlen = "100" styles="width:100%"  onenterkey="OnSetToGrid(2)" /></td>
		            <td align=right ><gw:imgBtn id="ibtnSet2" alt="Set Grid" img="set" text="" onclick="OnSetToGrid(2)" /></td>
		            <td align=center colspan=4 style="color:Red;"><gw:label id="idRecord" text="0 rec(s)" styles="width:100%;color:red" ></gw:label>
		            </td>
                </tr>	
                <tr style="height:6%;border:0">	
		            <td align=right colspan=4></td>
		            <td align=left colspan=4><gw:icon id="idBtnImp" img="in" text="Import Data" onclick="OnImportNew()" /></td>
		            <td align=right colspan=2><gw:imgBtn id="ibtnSampleRpt" alt="Sample file" img="excel" text="Report" onclick="OnReport(1)" /></td>
		            <td align=left colspan=4 ></td>
		            <td align=right colspan=5>Total VND: </td>
		            <td align=right colspan=6>
						<b><gw:textbox id="idTotalVND" type="number" format="#,###,###,###.##R" text="-" styles="width:100%;color:red" /></b>
					</td>
		            <td align=right colspan=3> <b>Total USD:</b></td>
		            <td align=right colspan=5 >
		                <b><gw:label id="idTotalUSD" text="-" styles="width:100%;color:red" ></gw:label></b>
                    </td>
                    <td align=center></td>
		            <td align=right colspan=4 style="width:5%"></td>
		            <td align=left colspan=7></td>
		            <td align=right ></td>
		            <td align=center colspan=4 style="color:Red;"></td>
                </tr>	
                <!--tr style="height:6%;border:0">	
		            <td align=right colspan=4></td>
		            <td align=right colspan=4>
						<gw:icon id="idBtnImp" img="in" text="Import Data" onclick="OnImportNew()" />
					</td>
					<td align=right colspan=2><gw:imgBtn id="ibtnSampleRpt" alt="Sample file" img="excel" text="Report" onclick="OnReport(1)" /></td>
		            <td align=left colspan=15 style="display:none" >
		                <input id="inputfile" type="file" name="pic" size="60" accept="image/jpg">
		            </td>	
		            <td align=left colspan=1 style="display:none" ></td>
		            <td align=left colspan=1  style="display:none" >
		                <gw:imgBtn img="process" id="ibtnProcess"   alt="Insert from Excell to Grid"  onclick="OnLoadExcel()"/>
		            </td> 
					<td align=left  style="display:none" >
						<gw:imgBtn id="ibtnSaveImport" alt="Save to Database" img="save" text="Save to Database" onclick="OnSaveImport()" />
					</td>
		            <td align=center colspan=4>
		               <b>Total VND:</b>
		            </td>
		            <td align=center colspan=4 style="color:Red;">
						<b><gw:textbox id="idTotalVND" type="number" format="#,###,###,###.##R" text="-" styles="width:100%;color:red" /></b>
		            </td>
					<td align=center colspan=3>
		               <b>Total USD:</b>
		            </td>
		            <td align=center colspan=3 style="color:Red;">
						<b><gw:label id="idTotalUSD" text="-" styles="width:100%;color:red" ></gw:label></b>
		            </td>
                </tr-->	
                
	        </table>
	        <table id="tblMain" style="width:100%;height:82%" border=1 cellpadding="0" cellspacing="0">
	            <tr style="width:100%;height:100%">
	                <td id="tdMaster" style="width:100%">
	                    <gw:grid   
				        id="idGrid"  
				        header="Organization|Emp ID|Full Name|Date|Adj Type|Amount|Money Kind|Tax Y/N|Note|_emp_pk|_pk|Left Date"   
				        format="2|2|2|4|0|1|0|0|0|0|0|4"  
				        aligns="2|0|2|0|1|0|1|1|1|0|0|0"  
				        defaults="|||||||||||"  
				        editcol="1|0|0|0|1|1|1|1|1|0|0|0"  
				        widths="3000|1500|3000|1500|1500|2000|1500|1500|4000|0|0|1200"  
				        styles="width:100%; height:100% "   
				        sorting="T" 
				        acceptnulldate  
				        oncellclick     = ""/>
	                </td>
	            </tr>
	        </table>
	    </td>
	</tr>
</table>

   <gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
	<gw:textbox id="txtorg_tmp" styles="display:none"/>
<gw:textbox id="txtwg_tmp" styles="display:none"/> 
<gw:textbox id="menu_id" text="" styles="display:none"  />
<gw:textbox id="txtFlag_View" text="" styles="display:none"  />
<gw:textbox id="txtSequence" text="" styles="display:none"  />
<gw:textbox id="txtRecord" text="" styles="display:none"  />
<gw:textbox id="idDBUSR" text="" styles="display:none"  />
</body>
</html>

