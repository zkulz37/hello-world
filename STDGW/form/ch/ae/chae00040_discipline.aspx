<!-- #include file="../../../system/lib/form.inc"  -->
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
 p_emp_pk="<%=Request.querystring("p_emp_pk")%>";
 p_dis_pk="<%=Request.querystring("p_dis_pk")%>";
function BodyInit()
{txtEmp_pk.text=p_emp_pk;
txtDis_pk.text=p_dis_pk;
   datDis.Call();
}
function OnDataReceive(obj)
{
 auto_resize_column(grdLBHist,0,grdLBHist.cols-1,9);   
  for(var i=1 ; i< grdLBHist.rows ;i++)
    {   if( grdLBHist.GetGridData(i,10)=='1') 
        {grdLBHist.SetCellBgColor(i,0,i,10,0x0000FF);
        
        }}
      
}
//---------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//-
 
</script>
<body bgcolor='#F5F8FF'>
<gw:data id="datDis" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid"  function="HR.SP_SEL_discipline_HIS" > 
                <input bind="grdLBHist">
                    <input bind="txtEmp_pk" /> 
                    <input bind="txtDis_pk" />
                 </input> 
                <output bind="grdLBHist"/>
            </dso> 
        </xml> 
</gw:data>


<!------------------------------------------------------>
<table align = top style='margin-left:10px'  cellspacing=0 cellpadding=0 border=0 style="width:100%;height:100%;">
<tr>
	<td> 	
	    <table width="100%" height=7% cellspacing=0 cellpadding=0 >		
			<tr>
				<td align ="center" width=100%><b style="color:#FF0066; font-size:15"> DISCIPLINE HISTORY</b></td>
  			</tr>
  			<tr>
				<td align ="right" width=100%><b><gw:label id="lblRecord" text="" maxlen = "100" styles="color:#black;width:90%;font-weight: bold;font-size:12"></gw:label></b></td>
  			</tr>
		</table>
		<table width="100%" height=93% border=1 cellspacing=0 cellpadding=0 >		
			<tr>
				<td align = top height=100% >					
				<gw:grid   
	                            id="grdLBHist"  
	                            header="Emp Id|Full Name|D.O.J|Create Date|Level|Treat Disciplinary|Reason|Period|Start|End|Note|_select"   
	                            format="0|0|4|4|0|0|0|0|4|4|0|0"   
	                            aligns="0|0|0|0|0|0|0|0|0|0|0|0"   
	                            acceptNullDate
	                            defaults="|||||||||||"   
	                            editcol="0|0|0|0|0|0|0|0|0|0|0|0"   
	                            widths="1000|2000|1000|1000|1500|1500|1500|1500|1500|1500|1500|0"   
	                            styles="width:100%; height:100%"   
	                            sorting="T"   
	                            oncellclick=""/> 
  				</td>
  			</tr>
		</table>
	</td>		
</tr>	
</table>
<!--data-->
<gw:textbox id="txtEmp_pk"  text="0" style="display:none"/>
<gw:textbox id="txtDis_pk"  text="0" style="display:none"/>

</body>
</html>
