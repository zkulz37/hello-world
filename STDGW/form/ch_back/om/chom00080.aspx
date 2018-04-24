<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("hr")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var dt_tmp
var opt_value=1
var flag_imp=0;

var v_language = "<%=Session("SESSION_LANG")%>";

var c_emp_id=3
var c_nm=4
var c_allow_nm=5
var c_yn=7;
var c_remark=8
var c_amount=6;
var c_mon=10
var c_imp_seq=11
function BodyInit()
{
    idGrid.GetGridControl().ScrollTrack=true;
    idGrid.GetGridControl().FrozenCols =5;
    if (v_language!="ENG")
        System.Translate(document);
     <%=ESysLib.SetGridColumnComboFormatString2( "idGrid" , 7 , "Y|YES|N|NO") %>; 
     var t1 = "<%=ESysLib.SetGridColumnDataSQL("select a.kind,a.name from thr_allowance_master a where a.del_if=0 order by a.kind")%>";
       idGrid.SetComboFormat(c_allow_nm,t1);
      
      idemp_pk.text = "<%=session("USER_PK")%>";
      txtHr_level.text= "<%=session("HR_LEVEL")%>";
    if((Trim(idemp_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
        datUser_info.Call();     	    
    else
         datCheck_Month_allowance.Call();
	   	    
	
}
//---------------------------------------------------
function OnShowPopup()
{
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:200;dialogTop:200;edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
             lstOrg.value=obj;
        }
}
//------------------------------------------------------------------------------------
function OnChangeDept()
{
    //txtDept.text=lstOrg.value;
    datGroupData.Call();
}
//------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    if (obj.id=="datUser_info")
            datGroupData.Call();
    else if (obj.id=="datCheck_Month_allowance")
    {
        //ibtnSearch.SetEnable(Number(lbltmp.text));
       /* if(Number(lbltmp.text)==0)
            lblRecord.text="Haven't data";
        else               
            lblRecord.text="";*/
        if(Number(lbltmp2.text)==0)
            lblRecord.text="This month close";
            
        ibtnSave.SetEnable(Number(lbltmp2.text));    
            
        if((Trim(idemp_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
            datUser_info.Call();   
    }
       else if (obj.id=="datUnfix_allowance")
       {
            lblRecord.text=idGrid.rows-1 + " records."
            var tmp=0;
            for(var i=1;i<idGrid.rows;i++)
            {
                if(idGrid.GetGridData(i,c_amount)!="")
                    tmp+=Number(idGrid.GetGridData(i,c_amount))
            }    
            lblRecord2.text="  Total:" +tmp;
            auto_resize_column(idGrid,0,idGrid.cols-1,0);
       }
       else if(obj.id == "datUnfix_allowance_imp")
       {
             lblRecord.text=idGrid.rows-1 + " records."
             var tmp=0;
            for(var i=1;i<idGrid.rows;i++)
            {
                if(idGrid.GetGridData(i,c_amount)!="")
                    tmp+=Number(idGrid.GetGridData(i,c_amount))
            }    
            lblRecord2.text="  Total:" +tmp;
            auto_resize_column(idGrid,0,idGrid.cols-1,0);
       }
      
	   
}     
//------------------------------------------------------------------------------------
function OnSearch()
{
    flag_imp=0;
    idImp_seq.text="";
    if(Trim(idtxtTmp.text)==""&&lstAll_kind.value=="ALL")
    {
        if(confirm("Data will be overload. Do you want to continous?\nDữ liệu có thể sẽ rất nhiều. Bạn có muốn tiếp tục?"))
            datUnfix_allowance.Call("SELECT");  
    }
    else       
        datUnfix_allowance.Call("SELECT");  
           
        
}
//------------------------------------------------------------------------------------
function OnUpdate()
{
    
    var i;
  if(idGrid.GetGridControl().rows>1)
  {
    
    for(i=1;i<idGrid.rows;i++)
    {
        
        if(idGrid.GetGridData(i,c_allow_nm)=="" && idGrid.GetGridData(i,c_amount)!="")
        {
            alert("Please choose allowance name at row:"+i)
            return;
        }
    }
  }  
    
    if(confirm("Do you want to save?\nBạn đã chắc chắn save?"))
    {
        if(flag_imp==1)
            datUnfix_allowance_imp.Call();
        else
            datUnfix_allowance.Call();    
    }   
}
//------------------------------------------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
function onChangeMonth()
{
    idGrid.ClearData();
    datCheck_Month_allowance.Call();
}
/*function Popup()
{
    var col=event.col;
    if(col>4&&col<15)
    {
        if(idGrid.GetGridData(event.row,event.col)!="")
        {
            col=event.col-4;
            var fpath = System.RootURL + "/form/ch/cs/chcs00080_Popup.aspx?emp_id=" + idGrid.GetGridData(event.row,2) + "&kind=" + idGrid.GetGridData(event.row,17)+ "&rule_kind=" + col+ "&work_mon=" + dtMonth.value;
            var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:70;dialogHeight:40;dialogLeft:50;dialogTop:50;edge:sunken;scroll:yes;unadorned:yes;help:no');
         }   
    }    
}*/
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
    if(n==1)
    {
        if(Number(idtxtAmount.text)>0)
        {
            if(idGrid.rows>1)
            {
                var ctrl=idGrid.GetGridControl();
                if(ctrl.SelectedRows>0)
                {
                    for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
            	            idGrid.SetGridText(ctrl.SelectedRow(i),c_amount,idtxtAmount.text);
        			
                }
                else
                {
                    if(confirm("Do you want to set all rows?\nBạn có muốn set hết tất cả các dòng ở dưới lưới"))
                    {
                        for ( var i =  1 ; i < ctrl.Rows ; i++ )
            	                idGrid.SetGridText(i,c_amount,idtxtAmount.text);
                    }
                }
            }
            
        }    
    }
    else
    {
        if(idGrid.rows>1)
            {
                var ctrl=idGrid.GetGridControl();
                if(ctrl.SelectedRows>0)
                {
                    for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
            	            idGrid.SetGridText(ctrl.SelectedRow(i),c_yn,idSet_Fix.value);
        			
                }
                else
                {
                    if(confirm("Do you want to set all rows?\nBạn có muốn set hết tất cả các dòng ở dưới lưới"))
                    {
                        for ( var i =  1 ; i < ctrl.Rows ; i++ )
            	                idGrid.SetGridText(i,c_yn,idSet_Fix.value);
                    }
                }
            }
        
    }    
}
//--------------------
function OnReport()
{
    var url =System.RootURL + '/reports/ch/cs/rpt_unfixed_allowance.aspx?l_tco_org_pk='+lstOrg.value+'&l_wg='+lstWG.value+'&l_work_mon='+dtMonth.value+'&l_kind='+lstAll_kind.value+'&l_search='+idSearch.value+'&l_input='+idtxtTmp.text+'&l_amount='+lstAMT.value+'&l_imp_seq='+idImp_seq.text;
    window.open(url);
}
function OnSampleReport()
{
	var url =System.RootURL + '/reports/ch/cs/rpt_unfixed_allowance_sample.aspx' ;
    window.open(url);
}


function CheckValidFile(vfile)
{
    var sext;
    sext=vfile.substring(vfile.length-4,vfile.length);
    if (sext!=".xls")
        return false;
    return true;
}
function Remove_empty_rows()
{
    var tmp=0;
    var i=1;
  if(idGrid.GetGridControl().rows>1)
  {
    var row=idGrid.GetGridControl().rows;
    
    while(i<row)
    {
        if(idGrid.GetGridData(i,c_emp_id).length<4)
        {   
            idGrid.RemoveRowAt(i);
            i-=1;
            row=idGrid.GetGridControl().rows;
        }
        i+=1;    
    }
    
    lblRecord.text=idGrid.rows-1 + " records."
    for(i=1;i<idGrid.rows;i++)
    {
        if(idGrid.GetGridData(i,c_amount)!="")
            tmp+=Number(idGrid.GetGridData(i,c_amount))
    }    
    lblRecord2.text="  Total:" +tmp;
    auto_resize_column(idGrid,0,idGrid.cols-1,0);
  } 
  
  //clear_Interval(idRecord);
  
}
function OnLoadExcel()
{
	if (lstAll_kind.value=='ALL')
	{
		alert('Please choose one Allowance kind only !');
		return;
	}
	
	var vfilename = document.all["inputfile"].value;    
	imp_seq=new Date().getTime();
	idImp_seq.text=imp_seq;
	
	if (!CheckValidFile(vfilename) || vfilename =="")
	{
		alert("Please select excel file");
		return;
	}

	idGrid.ClearData();
	idtxtTmp.text="";  
	try
	{
		var myApp = new ActiveXObject("Excel.Application");     
		myApp.Workbooks.Open(vfilename); 
		var workSheet = myApp.ActiveSheet; 
		var vemp_id,vemp_name, vamount;
		var maxRow =workSheet.UsedRange.Rows.Count; 
		//alert(maxRow);
		//return;
		for (var j =3;j <= maxRow; j++) 
		{ 
			vemp_id=workSheet.Cells(j,2).value;                        
			vemp_name=workSheet.Cells(j,3).value;
			vamount=workSheet.Cells(j,4).value;		
			vremark=workSheet.Cells(j,5).value;	
			                   
				idGrid.AddRow();
				var irow=idGrid.rows-1;
				idGrid.SetGridText(irow,c_emp_id,vemp_id);
				idGrid.SetGridText(irow,c_nm,vemp_name);				
				idGrid.SetGridText(irow,c_allow_nm,lstAll_kind.value);                    
				idGrid.SetGridText(irow,c_amount,vamount);   
				idGrid.SetGridText(irow,c_yn,'Y');
				idGrid.SetGridText(irow,c_remark,vremark);
				idGrid.SetGridText(irow,c_mon,dtMonth.value);/**/
				idGrid.SetGridText(irow,c_imp_seq,imp_seq);/**/
		} 
		flag_imp=1;
		myApp.Quit();
		myApp=null;
	}
	catch(e)
	{
		alert("Could not read Excel File !"); 
		myApp.Quit();
	}
	Remove_empty_rows();
	
	
}
function OnDelete()
{
    if(confirm("Do you want to save?\nBạn đã chắc chắn save?"))
    {
        idGrid.DeleteRow();
    }
    
}

	
	
</script>

<body>
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr.sp_sel_user_role2"  > 
                <input>
                    <input bind="idemp_pk" />
                </input> 
                <output>
                    <output bind="lstOrg" />
                </output>
            </dso> 
        </xml> 
</gw:data>


<gw:data id="datUnfix_allowance" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,3,5,6,7,8,9,10,11" function="HR.SP_SEL_UNFIX_ALLOWANCE_UR" procedure="HR.sp_upd_UNFIX_ALLOWANCE_UR"> 
                <input bind="idGrid" >
                    <input bind="lstOrg" />
                    <input bind="lstWG" />
                    <input bind="dtMonth" />
                    <input bind="lstAll_kind" />
                    <input bind="idSearch" />
                    <input bind="idtxtTmp" />
                    <input bind="lstNation" />
                    <input bind="lstAMT" />
                    <input bind="idImp_seq" />
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datUnfix_allowance_imp" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,3,5,6,7,8,9,10,11" function="HR.SP_SEL_UNFIX_ALLOWANCE_IMP_UR" procedure="HR.sp_upd_UNFIX_ALLOWANCE_UR"> 
                <input bind="idGrid" >
                    <input bind="lstOrg" />
                    <input bind="lstWG" />
                    <input bind="dtMonth" />
                    <input bind="lstAll_kind" />
                    <input bind="idSearch" />
                    <input bind="idtxtTmp" />
                    <input bind="lstNation" />
                    <input bind="lstAMT" />
                    <input bind="idImp_seq" />
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datCheck_Month_allowance" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_check_month_allow" > 
                <input >
                    <input bind="dtMonth" /> 
                </input>
                <output >
                    <output bind="lbltmp" /> 
                    <output bind="lbltmp2" /> 
                </output>
            </dso> 
        </xml> 
</gw:data>
<table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
	<table style="width:100%;height:15%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
	<tr style="height:5%;border:1">	
		<td colspan=2 align=right style="width:10%;border:0" >Work Month</td>
		<td colspan=2 align=center style="width:10%;border:0"><gw:datebox id="dtMonth"  maxlen = "10" text="" styles='width:50%'lang="<%=Session("Lang")%>" type="month" onchange="onChangeMonth()" /></td>
		
		<td colspan=2 align=right style="width:10%;border:0" ><a title="Click here to show organization" onclick="OnShowPopup()" href="#tips" >Organization</a></td>
		<td colspan=4 align=right style="width:20%;border:0"><gw:list  id="lstOrg"  value="ALL" styles='width:100%' onchange="" >
                <data>
                    <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from comm.tco_org a  where a.del_if = 0 and a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk)  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                </data>
            </gw:list>
        </td>
		<td colspan=2 align=right style="width:10%;border:0">Work Group</td>
		<td colspan=3 align=right style="width:15%;border:0"><gw:list  id="lstWG"  value="ALL" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select a.pk,a.workgroup_nm from thr_work_group a where a.del_if=0 ORDER BY NVL(A.SEQ,9999)")%>|ALL|Select All</data></gw:list>
        </td>
        <td colspan=2 align=right style="width:10%;border:0"><gw:list  id="lstAMT"  value="ALL" styles='width:100%' >
                            <data>|ALL|Amount=ALL|0|Amount<>0</data></gw:list>
        </td>
		<td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch()" /></td>
		<td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnSave" alt="Save" img="save" text="Save" onclick="OnUpdate()" /></td>
		<td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnDel" alt="Delete" img="delete" text="Delete" onclick="OnDelete()" /></td>
		<td align=right style="width:3%;border:0">&nbsp;</td>
		<td  align=right style="width:3%;border:0" ><gw:imgBtn id="ibtnRpt" alt="Report" img="excel" text="Report" onclick="OnReport()" /></td>
    </tr>	
    <tr style="height:5%;border:1">	
		<td colspan=2 align=right style="width:10%;border:0" >Allowance Name</td>
        <td colspan=2 align=right style="width:20%;border:0"><gw:list  id="lstAll_kind"  value="ALL" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("SELECT kind,name FROM THR_ALLOWANCE_MASTER WHERE DEL_IF = 0 order by KIND")%>|ALL|Select All</data></gw:list>
        </td>
		<td colspan=2 align=right style="width:10%;border:0">Search</td>
		<td colspan=2 align=right style="width:10%;border:0"><gw:list  id="idSearch" value="1" styles='width:100%' onChange="">
                <data>|1|Emp ID|2|Card ID|3|Name</data></gw:list>
        </td>
         <td colspan=2 align=right style="width:35%;border:0"><gw:textbox id="idtxtTmp" maxlen = "50" styles="width:100%" onenterkey="OnSearch()" /></td>       
         <td colspan=2 align=right style="width:10%;border:0"><b>Input file</b></td>
         <td colspan=8 align=right style="width:10%;border:0"><input id="inputfile" type="file" name="pic" style="width:100%"  accept="text/csv,text/xls"></td>       
         <td style="border:0;" align="right" >&nbsp;</td>
         <td align=right style="width:2%;border:0"><gw:imgBtn img="process" id="ibtnProcess"   alt="Insert from Excell to Grid"  onclick="OnLoadExcel()"/></td>
         <td align=left style="width:20%;border:0"><gw:imgBtn img="excel" id="ibtn7"    alt="Sample Reports"  onclick="OnSampleReport()"/></td>
         
    </tr>	
    <tr style="height:5%;border:1">	
        <td colspan=2 style="border:0;" align="right" >Nation</td>
        <td colspan=2 style="border:0;" align="left" >
         <gw:list  id="lstNation" value='01' maxlen = "100" styles='width:100%' >
            <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' and code in('01','02') order by code" )%>|ALL|Select All</data></gw:list>
        </td>
		 <td colspan=2 align=right style="width:10%;border:0"><b>Set Amount</b></td>
         <td colspan=2 align=right style="width:10%;border:0"><gw:textbox id="idtxtAmount" maxlen = "50" styles="width:100%" onkeypress="return Numbers(event)" /></td>       
         <td align=left style="width:5%;border:0"><gw:imgBtn id="ibtnSet" alt="Set Amount to Grid" img="set" text="" onclick="OnSetToGrid(1)" /></td>
         <td colspan=2 align=right style="width:10%;border:0">Byhand</td>
         <td align=right style="width:10%;border:0"><gw:list  id="idSet_Fix" value="Y" styles='width:100%' onChange="">
                <data>|Y|Yes|N|No</data></gw:list></td>
         <td align=left style="width:2%;border:0"><gw:imgBtn id="ibtnSet2" alt="Set to Grid" img="set" text="" onclick="OnSetToGrid(2)" /></td>
         <td colspan=2 align=right style="width:15%;border:0"><gw:label id="lblRecord"  text="" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
         <td colspan=6 align=right style="width:15%;border:0"><gw:label id="lblRecord2"  text="" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
    </tr>	
	
	</table>
	<table id="tbl" style="width:100%;height:85%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
		<tr style="height:100%">
			<td id="master" width="100%">
				<gw:grid
					id="idGrid"
					header="_PK|ORGANIZATION|WORK GROUP|EMP_ID|FULL_NM|ALLOW NAME|AMOUNT|FIX BYHAND|REMARK|_thr_emp_pk|_work_mon|_imp_seq"
					format ="0|0|0|0|0|0|1|0|0|0|0"
					aligns ="0|0|0|0|0|1|1|1|1|1|1"
					editcol="0|0|0|0|0|0|1|1|1|0|0" 
					defaults="||||||||||"					
					widths="1000|3000|2000|1500|3000|2000|2000|3000|1200|1200|1200"
					styles="width:100%;height:100%"
					sorting="T"
					oncelldblclick = ""/>
			</td>
		</tr>	
	</table>
</table>

	<gw:textbox id="txtResult" styles="display:none"/>
    <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
    <gw:textbox id="idemp_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="lbltmp" styles="display:none"/>
    <gw:textbox id="lbltmp2" styles="display:none"/>
    <gw:textbox id="idImp_seq" styles="display:none"/>
	
</body>
</html>

