<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Import General Information Data</title>
</head>

<script>
var dept,grp,flag=0;
var v_language = "<%=Session("SESSION_LANG")%>";
var _days=0;
var tmp1,tmp2,imp_seq;
var flag_save=0;
function BodyInit()
{       
    idMon_fr.SetEnable(0);   
    idMon_to.SetEnable(0);
    ibtnUpdate.SetEnable(0);
    if (v_language!="ENG")
        System.Translate(document);	
    if(idMon.value!="")
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
	
	if(obj.id=="datImportDuty")
	{
		idRecord.text=idGridAtt.rows-1+" record(s) imported.";
		flag_save=0;
		ibtnUpdate.SetEnable(0);
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
		datImportDuty.Call("SELECT");
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
	if(idMon.value=="")
	{
		alert("Please choose work month to import data")
		return;
	}
	if (!CheckValidFile(vfilename) || vfilename =="")
	{
		alert("Please select excel file");
		return;
	}	
	if(confirm("Read data from excel file will begin, please wait for a moment, are you sure?"))
	{
	   ImportAttendance();
	   Remove_empty_rows();
       idRecord.text=idGridAtt.rows-1+" record(s)";
       flag_save=1;
	}   
}

function ImportAttendance()
{
	idGridAtt.ClearData();	
	imp_seq=new Date().getTime();
	idImp_seq.text=imp_seq;
	
	try
	{
		var vfilename = document.all["inputfile"].value;    
		var myApp = new ActiveXObject("Excel.Application");     
		myApp.Workbooks.Open(vfilename); 
		var workSheet = myApp.ActiveSheet; 
		var maxRow =workSheet.UsedRange.Rows.Count;
		var j=2;
		//alert(maxRow)
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
			    idGridAtt.SetGridText(irow,35,imp_seq);
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
            datImportDuty.Call();
    }    
	
}

function OnChangeMon()
{
	for(var i=1;i<=31;i++)
		    idGridAtt.GetGridControl().ColHidden(i)=false;
	datGet_Period.Call();
	
}

function daysInMonth(month, year) 
{
    return new Date(year, month, 0).getDate();
}
function OnReport()
{
    //string p_dept, p_group, p_from, p_to, p_txtID, p_txtOpt;
    var url=System.RootURL+'/reports/ag/bh/rpt_schedule_duty_sample.aspx';
    window.open(url);
}
</script>

<body>
<!------------main control---------------------->


<gw:data id="datGet_Period" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_pro_get_sal_period" > 
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


<gw:data id="datImportDuty" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35" function="HR_SEL_80020016" procedure="HR_UPD_80020016">
                <input bind="idGridAtt" >
					<input bind="idMon" />
					<input bind="idMon_fr" />
					<input bind="idMon_to" />
					<input bind="idImp_seq" />
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

				<tr style="height:6%;border:1">
				    <td style="width:10%"><gw:list  id="idLst_period" value='02' maxlen = "100" styles='width:100%' onchange="OnChangeMon()">
                                <data>|01|By Period|02|By Month</data>
                            </gw:list>
                    </td>
					<td align=center style="width:5%" >W-Month</td>
		            <td align=left style="width:10%" ><gw:datebox id="idMon" type="month" lang="<%=Session("Lang")%>" nullaccept onchange="OnChangeMon()" /></td>					            	
					<td align=center style="width:5%"  >From</td>
		            <td align=left style="width:10%"  >
						<gw:datebox id="idMon_fr"  lang="<%=Session("Lang")%>" onchange="" />
					</td>		
					<td align=center style="width:2%" >~</td>	
					<td align=left style="width:10%" >
						<gw:datebox id="idMon_to"  lang="<%=Session("Lang")%>" onchange="" />
					</td>
					<td align=left style="width:8%"  ><gw:icon id="idBtnRpt" img="in" text="Sample Report" alt="Report Mẫu" onclick="OnReport()" /></td>													          
					<td align=right style="width:10%" ></td>									
					<td align=left style="width:10%"  ></td>
					<td align=center style="width:10%"  ></td>									
					
				</tr>
				<tr style="height:6%;border:1">
				    
					<td align=right >Excell file</td>									
					<td align=left colspan=4><input id="inputfile" type="file" name="pic" size="60"  style='width:100%' accept="text/csv,text/xls"></td>
					<td align=center colspan=2 ><gw:icon id="idBtnProcess" img="in" text="Read Data" alt="Read Excel File" onclick="OnLoadExcel()" /></td>
					<td align=center ><gw:icon id="ibtnUpdate" img="in" text="Import Data" alt="Import from excel" onclick="OnSave()" />
					<td align=center colspan=3><b><gw:label id="idRecord" styles="color:blue"></gw:label></b></td>
				</tr>
				                                
	        </table>
	        <table id="tblMaternity" style="width:100%;height:88%" border=1 cellpadding="0" cellspacing="0">
	            <tr style="width:100%;height:100%">
	                <td id="tdMaster" style="width:100%">
	                    <gw:grid   
				        id="idGridAtt"   header="EmpID|26|27|28|29|30|31|01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|_WORK_MON|_from|_to|_import_seq"   
				        format="0|0|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0|0|0|0|0|0|0	"
				        aligns="1|1|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1|1|1|1|1|0|0	"
				        defaults="||||||||||||||||||||||||||||||||||||"
			            editcol="0|1|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|0|0|0|0|0	"
				        widths="1000|700|700|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|1200|1200|1200|0|0	" 
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
		<gw:textbox id="idImp_seq" styles="display:none"/>
		
		
		</td>	
		</tr>
</table>
	
</form>
   
</body>
</html>
