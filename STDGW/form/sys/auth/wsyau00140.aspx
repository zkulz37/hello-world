<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser("hr")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Password Account Tool</title>
</head>
<script language="JavaScript" src="../../../system/lib/md5.js"></script>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{          
   datImportAccount.Call("SELECT");
}

function OnDataReceive(obj)
{
    lblRecord.text=idGridAccount.rows-1 + " record(s).";
}      

function OnReport()
{   
	var url=System.RootURL + '/reports/sys/auth/wsyau00140_tpl.aspx';
	window.open(url);	
}

function OnSearch()
{
	datImportAccount.Call("SELECT");
}


function CheckValidFile(vfile)
{
    var sext,sext2;
    sext=vfile.substring(vfile.length-4,vfile.length);
    sext1=vfile.substring(vfile.length-5,vfile.length);
    if (sext!=".xls" || sext1!=".xlsx")
        return false;
    return true;
}

function OnLoadExcel()
{	/*
	var vfilename = document.all["inputfile"].value;
	if (CheckValidFile(vfilename)|| vfilename =="")
	{
		alert("Please select excel file");
		return;
	}
	ImportAccount();/**/
	if(idGridAccount.rows == 1){
	    alert("No data for process");   
	}
	var temp = "";
	for(var idx = 1; idx < idGridAccount.rows; idx++){
	    //idGridAccount.GetGridData(idx, 1)
	    temp = Math.floor(Math.random()*Number(idGridAccount.GetGridData(idx, 1) + 10));
	    idGridAccount.SetGridText(idx, 4, temp);
	    idGridAccount.SetGridText(idx, 5, b64_md5(temp.toString()));
	}/**/
}

function ImportAccount()
{
	idGridAccount.ClearData();	
	try
	{
		var vfilename = document.all["inputfile"].value;    
		var myApp = new ActiveXObject("Excel.Application");     
		myApp.Workbooks.Open(vfilename); 
		alert("");
		var workSheet = myApp.ActiveSheet; 
		var vemp_id,vemp_name,vleft_user;
		var maxRow =workSheet.UsedRange.Rows.Count; 		  
		for (var j =3;j <= maxRow; j++) 
		{ 
			vemp_id=workSheet.Cells(j,2).value;                        
			vemp_name=workSheet.Cells(j,3).value;
			vleft_user=workSheet.Cells(j,4).value;							
			
			if (vemp_id=="" || vemp_id==null)
			   alert("Emp-ID cannot be blank at row: " + j);
			else if (vemp_name=="" || vemp_name==null)
				alert("Name cannot be blank at row: " + j);
			else if (vleft_user=="" || vleft_user==null )
				alert("User ID cannot be blank at row: " + j);            
			else
			{
				idGridAccount.AddRow();
				var irow=idGridAccount.rows-1;
				idGridAccount.SetGridText(irow,1,vemp_id);
				idGridAccount.SetGridText(irow,2,vemp_name);
				idGridAccount.SetGridText(irow,3,vleft_user);
			}			
		} 
		myApp.Quit();
	}
	catch(e)
	{
		alert("Could not read Excel File. (or) Excel was not installed in the machine you are using or it has incompatible version?");
		myApp.Quit(); 
	}	
}

function OnSave()
{
    OnLoadExcel();
	datImportAccount.Call();
}
</script>

<body>
<!------------main control---------------------->
<gw:data id="datImportAccount" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,4,5" function="esys.sp_sel_imp_account" procedure="esys.sp_pro_imp_account" > 
                <input bind="idGridAccount" >
				    <input bind="iduser_pk" /> 
                </input>
                <output  bind="idGridAccount" />
            </dso> 
        </xml> 
</gw:data>
<!--------------------main table--------------------------------->
<form name="frmimport" id="form2"  > 
<table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
	<tr>
	    <td>
	        <table style="width:100%;height:10%" cellpadding="0" cellspacing="0" valign="top" border="0" >	
				<tr style="height:6%;border:0">
		            <td align=right>Excell file</td>
		            <td align=left><input id="inputfile" type="file" name="pic" style="width:100%"  accept="text/csv,text/xls"></td>
					<td align="center"><gw:label id="lblRecord"  text="0 record(s)." maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:13" /></td>
	                <td align=left style="width:2%;width:1%" ><gw:imgBtn img="excel" id="ibtn7"    alt="Sample Reports"  onclick="OnReport()"/></td>		
					<td align=left style="padding-left:5px;width:1%"><gw:imgBtn img="process" id="ibtnProcess"   alt="Insert from Excell to Grid"  onclick="OnLoadExcel()"/></td>
					<td align=left style="padding-left:5px;padding-right:5px;width:1%"><gw:imgBtn id="ibtnUpdate" alt="Save" img="save" text="Save" onclick="OnSave()" /></td>
				</tr>
	        </table>
			<table id="tblAccount" style="width:100%;height:90%" border=0 cellpadding="0" cellspacing="0">
	            <tr style="width:100%;height:100%">
	                <td id="tdAccount" style="width:100%">
	                    <gw:grid   
				        id="idGridAccount"  
				        header="_PK| EmpID|Full Name|User ID|Pass (Not MD5)|Pass (MD5)"   
				        format="0|0|0|0|0|0"  
				        aligns="0|1|0|0|1|1"  
				        defaults="||||||"  
				        editcol="0|0|0|0|0|0"  
				        widths="0|1200|3500|3500|2500|2000"  
				        styles="width:100%; height:100% "   
				        sorting="T"   
				        acceptNullDate
				        oncelldblclick=""
				        oncellclick = ""/>
	                </td>
	            </tr>
	        </table>
        </td>
    </tr>
</table>
	<gw:textbox id="iduser_pk" styles="display:none" value="1" />
</form>
   
</body>
</html>
