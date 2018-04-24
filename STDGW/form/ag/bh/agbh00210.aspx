<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var arr;
var imp_seq;
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);	
    
}
//----------------------------------

function OnDataReceive(obj)
{
         if (obj.id=="datImport")
       {
            lblRecord.text=grdData.rows-1 + " record(s).";
         
            auto_resize_column(grdData,0,grdData.cols-1,9);
       }
       
}     
//------------------------------------------------------------------------------------
function OnSearch()
{
    datUpload_Data.Call("SELECT");  
  
}
//-----------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}

 //------------------------------------------
function OnSave()
{
    if (confirm("Do you want to save?"))
        datImport.Call();
}
//-------------------------------------------------
function OnLoadExcel()
{
 
 grdData.ClearData();	
 imp_seq=new Date().getTime();
 idImp_seq.text= imp_seq;
	try
	{
		var vfilename = document.all["inputfile"].value;    
		var myApp = new ActiveXObject("Excel.Application");     
		myApp.Workbooks.Open(vfilename); 
		var workSheet = myApp.ActiveSheet; 
		var v_emp_id,v_name, v_filename;
		var maxRow =workSheet.UsedRange.Rows.Count; 		  
		
		for (var j =4;j <= maxRow; j++) 
		{ 
			v_emp_id=workSheet.Cells(j,2).value;    
			v_name=workSheet.Cells(j,3).value;
            v_filename = workSheet.Cells(j,4).value;
                               
			             
				grdData.AddRow();
				var irow=grdData.rows-1;
				grdData.SetGridText(irow,0, v_emp_id);
                grdData.SetGridText(irow,1, v_name);
                grdData.SetGridText(irow,2, v_filename);
                grdData.SetGridText(irow,3, idImp_seq.text);
                
		
		} 
		myApp.Quit();
	}
	
	catch(e)
	{
		alert("Could not read Excel File. (or) Excel was not installed in the machine you are using or it has incompatible version?");
		myApp.Quit(); 
	}	
   // Remove_empty_rows();
}
function OnPrint()
{
    var url =System.RootURL + '/reports/ag/bh/rpt_Import_Image_Employees_Sample.aspx';
            window.open(url);
}
</script>

<body>
<gw:data id="datImport" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,2,3" function="HR_SEL_80020019" procedure="HR_UPD_80020019"> 
                <input bind="grdData" >
                    <input bind="idImp_seq" />
                </input>
                <output  bind="grdData" />
            </dso> 
        </xml> 
</gw:data>
<table name="Summary" style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
    <tr  style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1">
        <td>
	        <table id="Table1" style="width:100%;height:100%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
	            <tr style="height:10%">
	                <td  style="border:0" align="left" width="10%"></td>
			        <td  style="border:0" align="right" width="10%"><b>Excel File</b></td>
	                <td  style="border:0" align="left" width="20%">
                        <input id="inputfile" type="file" size="43"  accept="application/msexcel"  >
                    </td>
	                <td  align="center"  style="border:0" width="5%">
                        <gw:imgBtn id="ibtnSampleRpt" alt="Sample file" img="excel" text="Report" onclick="OnPrint()" />
                    </td>
		            <td  align="center"  style="border:0" width="5%">
                        <gw:imgBtn img="process" id="ibtnProcess"   alt="Insert from Excell"  onclick="OnLoadExcel()"/>
                    </td>		
			        <td  align="center"  style="border:0" width="5%">
                       
                    </td>
			        <td  align="left"  style="border:0" width="12%"></td>
			        
			        <td  align="right"  style="border:0" width="5%"></td>
			        <td  align="left"  style="border:0" width="10%"></td>
			        <td id="Td2" style="border:0" align="right" width="10%">
				        <gw:label   id="lblRecord" text="0 record(s)" styles="color:red;width:90%;font-weight: bold;font-size:12" ></gw:label>
			        </td>
			        <td id="Td3"  style="border:0" align="right" width="5%">
				       
			        </td>
			        <td id="Td4"  style="border:0" align="right" width="3%">
				        <gw:imgBtn id="ibtnSave" alt="Save" img="save" text="" onclick="OnSave()" />
			        </td>
			    </tr>	
        	    <tr style="height:90%">
			        <td id="Td1" width="100%" colspan=13 >
				        <gw:grid id='grdData'
                            header="Employee ID|Employee Name|Image Name|_Import Seq"
					        format="0|0|0|0"
					        aligns="0|0|0|0"
					        defaults="|||"
					        editcol="0|0|0|0"
					        widths="2000|2000|2000|2000"
					        styles="width:100%;height:100%"
					        sorting="T"
					        acceptNullDate="T" />
                            />
			        </td>
		        </tr>	
        		
	        </table>
	    </td>
	</tr>
</table>

<gw:textbox id="idImp_seq" styles="display:none"/>  


</body>
</html>

