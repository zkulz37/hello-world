﻿<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser("hr")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Import General Information Data</title>
</head>

<script>
var dept,grp,flag=0;
var v_language = "<%=Session("SESSION_LANG")%>";
var _days=0;
var tmp1,tmp2;
var flag_save=0;
function BodyInit()
{       
    idMon_fr.SetEnable(0);   
    idMon_to.SetEnable(0);
    if (v_language!="ENG")
        System.Translate(document);	
    
    datGet_Period.Call();
}
function set_Interval(x) 
{
 startTime = new Date().valueOf();
 interval_time=setInterval("clock(" + startTime + "," + x  + ")",x);
}

function clock(start,x) 
{
 var d = new Date()
 idRecord.text= Math.round((d.valueOf()-start)/x);

}

function clear_Interval(obj)
{
	clearInterval(interval_time);
	obj.text="";
}

function OnDataReceive(obj)
{
	if (obj.id=="datDeptData")
	{
		if(txtHr_level.text=="6")
			txtDeptData.text=txtDeptData.text+"|ALL|Select All";
		lstOrg.SetDataText(txtDeptData.text)    ;		
		obj=lstOrg.GetControl();
		if (obj.options.length ==2)
			obj.options.selectedIndex=0;
		else
			obj.options.selectedIndex=0;            
	}  /**/ 
	if(obj.id=="datImportAttendance")
	{
		idRecord.text="Import finish";
		flag_save=0;
		ibtnUpdate.SetEnable(0);
	}
	if(obj.id=="datInsert_master")
	{
	    if(idResult.text=="0")
	    {
	        ImportAttendance();
	        Remove_empty_rows();
	        clear_Interval(idRecord);
	        idRecord.text=idGridAtt.rows-1+" rec(s)";
	        flag_save=1;
	    }
	    else
	    {
	        clear_Interval(idRecord);
	        idRecord.text="Error. Not finish";
	    }    
	}
	if(obj.id=="datGet_Period")
	{
	    
	    var n;
	    _days=daysInMonth(idMon_fr.value.substring(4,6),idMon_fr.value.substring(0,4));	
		tmp1=Number(idMon_fr.value.substring(6,8));
		tmp2=Number(idMon_to.value.substring(6,8));
		//alert(tmp2)
		if(tmp2<_days)//chu ky giua thang
		{
		    for(var i=tmp1;i<=31+tmp2;i++)
		    {
		        if(i>31)
		            n=i-31
		         else
		            n=i   
		        idGridAtt.SetGridText(0,i-tmp1+1,n);
		    }    
		    for(var i=1;i<=31-_days;i++)
		    idGridAtt.GetGridControl().ColHidden(i+_days-tmp1+1)=true;
		}
		else
		{
		    for(var i=1;i<=31;i++)
		        idGridAtt.SetGridText(0,i,i);
		        
		    for(var i=1;i<=31-_days;i++)
		    idGridAtt.GetGridControl().ColHidden(i+_days)=true;    
		} 
		
		if(idClose_flag.text=="Y")
		{
		     idRecord.text="This month is close";
		     //inputfile.
		}     
		else
		{
		    idRecord.text="";     
		   // inputfile..SetEnable(1);
		}    
	}
	
}      

function OnPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:25;dialogHeight:30;dialogLeft:10;dialogTop:240;edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        lstOrg.value=obj;
        
    }   
}

function OnReport()
{   
	
}

function OnSearch()
{
	if(	frmimport.option_P[0].checked)
	{
		datImportAttendance.Call("SELECT");
	}
	
	
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
  if(idGridAtt.GetGridControl().rows>1)
  {
    var row=idGridAtt.GetGridControl().rows;
    var i=1;
    while(i<row)
    {
        if(idGridAtt.GetGridData(i,0).length<4)
        {   
            idGridAtt.RemoveRowAt(i);
            i-=1;
            row=idGridAtt.GetGridControl().rows;
        }
        i+=1;    
    }
  } 
  
  //clear_Interval(idRecord);
  
}

function OnLoadExcel()
{	
	var vfilename = document.all["inputfile"].value;    
	if (!CheckValidFile(vfilename) || vfilename =="")
	{
		alert("Please select excel file");
		return;
	}	
	if(confirm("Read data from excel file will begin, please wait for a moment, are you sure?"))
	{
	    set_Interval(100);
	    datInsert_master.Call();
	}   
}

function ImportAttendance()
{
	idGridAtt.ClearData();	
	try
	{
		var vfilename = document.all["inputfile"].value;    
		var myApp = new ActiveXObject("Excel.Application");     
		myApp.Workbooks.Open(vfilename); 
		var workSheet = myApp.ActiveSheet; 
		var maxRow =workSheet.UsedRange.Rows.Count;
		var j=2;
		while(j<=maxRow) 		  
		{
		   //if(workSheet.Cells(j,1).value.length>=4)
		   //{
			    idGridAtt.AddRow();
			    var irow=idGridAtt.rows-1;
			    var day_null=Number(idMon_fr.value.substring(6,8)); //day_null: ngay bat dau cua chu ky 			
			    idGridAtt.SetGridText(irow,0,workSheet.Cells(j,1).value);
			    var t=1;
			    var col_trong=0
			    while(t<=Number(idnum_day.text))//idnum_day: so ngay trong chu ky 			
			    {   
			        if(day_null>31)
			            day_null=0;
			        if(day_null<=_days)
			            idGridAtt.SetGridText(irow,t+col_trong,workSheet.Cells(j,t+1).value); 
			        else{
			            idGridAtt.SetGridText(irow,t,"");
			            t-=1;//dung lai 1 column
			            col_trong+=1;
			            }
			        day_null+=1;         
				    t+=1;  
			    }
			    idGridAtt.SetGridText(irow,32,idMon.value);	
			    idGridAtt.SetGridText(irow,33,idMon_fr.value);
			    idGridAtt.SetGridText(irow,34,idMon_to.value);
			//}   
		    j+=1; 
		 }   
		myApp.Quit();
		myApp=null;
		flag_save=1;
		ibtnUpdate.SetEnable(1);
		
	}
	catch(e)
	{
	    
		alert("Could not read Excel File. (or) Excel was not installed in the machine you are using or it has incompatible version?"); 
	}
}


function OnSave()
{
	if(flag_save==1)
	{
	    if(confirm("Do you want to import?\nBạn đã chắc chắn import?"))
            datImportAttendance.Call();
    }    
	
}

function OnChangeMon()
{
	for(var i=1;i<=31;i++)
		    idGridAtt.GetGridControl().ColHidden(i)=false;
	datGet_Period.Call();
	
}

function daysInMonth(month, year) {
    return new Date(year, month, 0).getDate();
}
function OnReport()
{
    //string p_dept, p_group, p_from, p_to, p_txtID, p_txtOpt;
    var url=System.RootURL+'/reports/ag/bh/rpt_schedule_detail_sample.aspx';
    window.open(url);
}
</script>

<body>
<!------------main control---------------------->


<gw:data id="datGet_Period" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_get_sal_period" > 
                <input >
                    <input bind="idMon" /> 
                    <input bind="idLst_period" />
                </input>
                <output >
                    <output bind="idMon_fr" /> 
                    <output bind="idMon_to" /> 
                    <output bind="idnum_day" />
                    <output bind="idClose_flag" />  
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datInsert_master" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_wg_excel_s1" > 
                <input >
                    <input bind="idMon" /> 
                    <input bind="idMon_fr" />
                    <input bind="idMon_to" />
                </input>
                <output >
                    <output bind="idResult" /> 
                </output>
            </dso> 
        </xml> 
</gw:data>



<gw:data id="datImportAttendance" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34" function="hr.sp_sel_imp_schedule" procedure="hr.sp_pro_imp_schedule">
                <input bind="idGridAtt" >
					<input bind="lstOrg" />
					<input bind="lstWG" />
					<input bind="lstStatus" />
					<input bind="idMon" />
					<input bind="idMon_fr" />
					<input bind="idMon_to" />
					<input bind="lstTemp" />
					<input bind="txtTemp" />
                </input>                 
                <output bind="idGridAtt" />                
            </dso> 
        </xml> 
</gw:data>
<!--------------------main table--------------------------------->

<form name="frmimport" id="form2"  > 
<table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
	<tr>
	    <td>
	        <table style="width:100%;height:12%" cellpadding="0" cellspacing="0" valign="top" border="0" >	
				<tr style="height:6%;border:0">	
					<td align=center colspan=4 style="width:8%" >
						<a title="Click here to show Organization" onclick="OnPopup()" href="#tips" >Oganization</a>
					</td>
		            <td align=left colspan=10 style="width:20%" >
						<gw:list  id="lstOrg" value='ALL' styles='width:100%'onchange="OnChangeOrg()" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from comm.tco_org a where a.del_if=0 order by a.seq")%>|ALL|Select All
                            </data>
                        </gw:list></td>					            	
					<td align=right colspan=3 style="width:6%" >W-Group</td>
		            <td align=left colspan=5 style="width:10%" >
						<gw:list  id="lstWG" value='ALL' styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select a.PK,a.WORKGROUP_NM from thr_work_group a where a.del_if=0 order by a.WORKGROUP_NM")%>|ALL|Select All</data>
						</gw:list>
					</td>					
			
					<td align=right colspan=3 style="width:6%" >Status</td>
		            <td align=left colspan=5 style="width:10%" >
						<gw:list  id="lstStatus" value='ALL' styles='width:100%'>
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0022' order by code_nm")%>|ALL|Select All
                            </data>
                        </gw:list>
					</td>
			
					<td align=right colspan=3 style="width:6%" >Search by</td>
		            <td align=center colspan=4 style="width:8%" >
						<gw:list  id="lstTemp" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Personal ID|5|Old Code</data> 
						</gw:list>
					</td>
					<td align=left colspan=5 style="width:10%">
						<gw:textbox id="txtTemp" onenterkey   ="OnSearch()" styles="width:100%"/>
					</td>
					<td align=center colspan=7 style="width:16%" ></td>
					<td align=right style="width:3%"><gw:imgBtn id="ibtnRpt" alt="Report" img="excel" text="Sample Report" onclick="OnReport()" /></td>
		            								
				</tr>

				<tr style="height:6%;border:1">
				    <td colspan=4><gw:list  id="idLst_period" value='01' maxlen = "100" styles='width:100%' onchange="OnChangeMon()">
                                <data>|01|By Period|02|By Month</data>
                            </gw:list>
                    </td>
					<td align=center colspan=4 >W-Month</td>
		            <td align=left colspan=4 ><gw:datebox id="idMon" type="month" lang="<%=Session("Lang")%>" onchange="OnChangeMon()" /></td>					            	
					<td align=center colspan=2  >From</td>
		            <td align=left colspan=3  >
						<gw:datebox id="idMon_fr"  lang="<%=Session("Lang")%>" onchange="" />
					</td>		
					<td align=center >~</td>	
					<td align=left colspan=3 >
						<gw:datebox id="idMon_to"  lang="<%=Session("Lang")%>" onchange="" />
					</td>													          
					<td align=right colspan=4  >Excell file</td>									
					<td align=left colspan=15  ><input id="inputfile" type="file" name="pic" size="60"  style='width:100%' accept="text/csv,text/xls"></td>
					<td align=center colspan=8  ><b><gw:label id="idRecord" styles="color:blue"></gw:label></b></td>									
					<td align=left style="width:2%"  ><gw:imgBtn img="process" id="ibtnProcess"   alt="Read Excel File"  onclick="OnLoadExcel()"/></td>
					<td align=left style="width:2%"  ></td>
					<td align=left style="width:2%" ><gw:imgBtn id="ibtnUpdate" alt="Save" img="save" text="Save" onclick="OnSave()" /></td>
					
				</tr>
				                                
	        </table>
			
	        <table id="tblMaternity" style="width:100%;height:88%" border=1 cellpadding="0" cellspacing="0">
	            <tr style="width:100%;height:100%">
	                <td id="tdMaster" style="width:100%">
	                    <gw:grid   
				        id="idGridAtt"   header="EmpID|26|27|28|29|30|31|01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|WORK_MON|_from|_to"   
				format="0|0|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0|0|0|0|0	"
				aligns="1|1|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1|1|1|1|1	"
				defaults="||||||||||||||||||||||||||||||||||"
			   editcol="0|1|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|0|0|0	"
				widths="1000|700|700|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|1200|1200|1200	" 
				        styles="width:100%; height:100% "   
				        sorting="T"   
				        acceptNullDate
				        oncelldblclick=""
				        oncellclick = ""/>
	                </td>
	            </tr>
	        </table>  
		<gw:textbox id="idnum_day" styles="display:none"/>
		<gw:textbox id="idClose_flag" styles="display:none"/>
		<gw:textbox id="idResult" styles="display:none"/>
		
		
		</td>	
		</tr>
</table>
	
</form>
   
</body>
</html>