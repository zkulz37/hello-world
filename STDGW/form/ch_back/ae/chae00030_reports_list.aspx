<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var arr_pk_char    =new Array();
var arr_len_char    =new Array();
var arr_Temp    =new Array();
var sCharacters;
var sExa_Characters;
var sTemplates;
var sExa_Templates;
var bend;
var binit=true;
var v_language = "<%=Session("SESSION_LANG")%>";
 

function BodyInit()
{   
    txtformID.text="<%=Request.querystring("formID")%>";	
    txtrpt_no="<%=Request.querystring("rpt_no")%>";     
    iduser_pk.text = "<%=session("USER_PK")%>";
	//alert(iduser_pk.text);
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    if(txtrpt_no=='1')
        datReport_codenm.Call();
    else
        datReport_codefnm.Call();
 
}

function OnExit()
{ this.checked=true;
 var p_temp= this.value;
// alert(p_temp +"");
 var obj= Array();
 
 obj[0]=grdReport.GetGridData(p_temp,1);//report seq
 obj[1]=grdReport.GetGridData(p_temp,2);//report name
// obj[1]=grdReport.GetGridData(p_temp,3);//report code_fnm 
  // alert(obj);
  window.returnValue =obj ; 
	window.close();
}
function  OnDataReceive(obj)
{ 
    if(obj.id=="datReport_codenm")
    { if(grdReport.rows>1)
        {
        for(var i=1 ;i< grdReport.rows ;i++)
        {
          var tbl = document.getElementById('tblSample');
          var lastRow = tbl.rows.length;
          // if there's no header row in the table, then iteration = lastRow + 1
          var iteration = lastRow;
          var row = tbl.insertRow(lastRow);
          
          
          
          
          var cellRight = row.insertCell(0);
          var el = document.createElement('input');
          
          el.type = 'radio';
          el.name = 'report' //+ iteration;
          //el.id = 'report' ;//+ iteration;
          el.value=i;//grdReport.GetGridData(i,1)  ;
           el.onclick = OnExit;
           cellRight.appendChild(el);
         
         
         
         var cellLeft = row.insertCell(1);
          var textNode = document.createTextNode(grdReport.GetGridData(i,0));
          cellLeft.appendChild(textNode);
         }
        }
      else 
      {    var tbl = document.getElementById('tblSample');
          var lastRow = tbl.rows.length;
          var iteration = lastRow;
          var row = tbl.insertRow(lastRow);
          var cellLeft = row.insertCell(1);
          var textNode = document.createTextNode("Can't found report");
          cellLeft.appendChild(textNode);
      } 
    }

    else if(obj.id=="datReport_codefnm")
    { if(grdReport.rows>1)
        {
        for(var i=1 ;i< grdReport.rows ;i++)
        {
          var tbl = document.getElementById('tblSample');
          var lastRow = tbl.rows.length;
          // if there's no header row in the table, then iteration = lastRow + 1
          var iteration = lastRow;
          var row = tbl.insertRow(lastRow);
          
          
          
          
          var cellRight = row.insertCell(0);
          var el = document.createElement('input');
          
          el.type = 'radio';
          el.name = 'report' //+ iteration;
          //el.id = 'report' ;//+ iteration;
          el.value=i;//grdReport.GetGridData(i,1)  ;
           el.onclick = OnExit;
           cellRight.appendChild(el);
         
         
         
         var cellLeft = row.insertCell(1);
          var textNode = document.createTextNode(grdReport.GetGridData(i,0));
          cellLeft.appendChild(textNode);
         }
        }
      else 
      {    var tbl = document.getElementById('tblSample');
          var lastRow = tbl.rows.length;
          var iteration = lastRow;
          var row = tbl.insertRow(lastRow);
          var cellLeft = row.insertCell(1);
          var textNode = document.createTextNode("Can't found report");
          cellLeft.appendChild(textNode);
      } 
    }
}

</script>
<body bgcolor='#F5F8FF'>
<!------------------------------------------------------>
<gw:data id="datReport_codenm" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="HR_SP_SEL_REPORT_LIST_BY_ROLE" > 
                <input bind="grdReport" >
                 <input bind="txtformID" />
                 <input bind="iduser_pk" />
                 
                </input>
                <output  bind="grdReport" />
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datReport_codefnm" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="HR_SP_SEL_REPORT_LIST_BY_ROLE2" > 
                <input bind="grdReport" >
                 <input bind="txtformID" />
                 <input bind="iduser_pk" />
                 
                </input>
                <output  bind="grdReport" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------->
<form>
<table border='0' id="tblSample">
<tr style="height:0%">
<td style="width:10%"></td>
<td style="width:80%"></td>
<td style="width:10%"></td>
</tr>
<tr>
    <td  colspan="2" align="center" style=" color:Blue" >Please chooce report name </td>
    <td>
    
    </td>
</tr>

</table>
</form>
<!--data-->
<gw:textbox id="txtformID"  text="0" style="display:none"/>
<gw:grid   
    id="grdReport"  
    header="display_name|report seq|report name"
    format="0|0|0"  
    aligns="0|2|2"  
    defaults="|||"  
    editcol="0|0|0"  
    widths="0|1500|1600"  
    styles="display:none" 
    sorting="T"    
/> 

<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>  

</body>
</html>
