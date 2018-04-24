<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser("hr")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Salary History</title>
</head>
<script>

var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    grdProduction.GetGridControl().ScrollTrack=true;
    grdProduction.GetGridControl().FrozenCols =5;
    if (v_language!="ENG")
        System.Translate(document);
	txtEmp_PK.text="<%=request.QueryString("l_emp_pk")%>";
	txtMonth.text="<%=request.QueryString("l_month")%>";
	txtItem_PK.text="<%=request.QueryString("l_item_pk")%>";
	txtGroup_Special.text="<%=request.QueryString("l_group_special")%>";
	ChangeHeader();
	dat_prod_detail.Call("SELECT");
}
//--------------------------------
function ChangeHeader()
{
    if (txtGroup_Special.text=='N')
    {
        grdProduction.SetGridText(0,8,'Labour Price');
        grdProduction.GetGridControl().ColFormat(9) = "(#,###.#)";
        grdProduction.GetGridControl().ColHidden(3)=0;
        grdProduction.GetGridControl().ColHidden(4)=0;
        grdProduction.GetGridControl().ColHidden(5)=0;
    }
    else
    {
        grdProduction.SetGridText(0,8,'Ratio');
        grdProduction.GetGridControl().ColFormat(9) = "(#,###.#%)";
        grdProduction.GetGridControl().ColHidden(3)=1;
        grdProduction.GetGridControl().ColHidden(4)=1;
        grdProduction.GetGridControl().ColHidden(5)=1;
    }
}
function DSOReceive( dsoinfo  )
{

	if ( dsoinfo.errno > 0 )
	{
		alert( dsoinfo.errmsg );
		return ;
	}	
}
function OnDataReceive()
{
    var ctrl=grdProduction.GetGridControl();
    ctrl.OutlineBar =2 ;
    var caption;
    var color;
    var maxgroup;
    color=0x99FF99;
    caption='Total:%s';
    ctrl.SubtotalPosition=0;
    ctrl.SubTotal(2,0, 10 ,'',color,0x000000,'1',caption,'',true);
    ctrl.SubTotal(2,0, 11,'',color,0x000000,'1',caption,'',true);  
    grdProduction.SetGridText(grdProduction.rows-1,1,'Total');
           
}

</script>
<body>
<gw:data id="dat_prod_detail" onreceive="OnDataReceive()" > 
        <xml> 
            <dso  type="grid"  parameter="" function="HR.sp_sel_prod_salary_detail"> 
                <input bind="grdProduction" >
                    <input bind="txtEmp_PK" />
                    <input bind="txtItem_PK" />
                    <input bind="txtGroup_Special" />
                    <input bind="txtMonth" />
                </input>
                <output  bind="grdProduction" />
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------------------>
<table align = top style='margin-left:10px' class="itable" cellspacing=0 cellpadding=0 border=0 style="width:100%;height:100%;">
<tr>
	<td> 	
	    <table width="100%" height=100% border=1 cellspacing=0 cellpadding=0 >		
			<tr>
				<td align = top height=100% >					
					<gw:grid   
                        id="grdProduction"  
                        header='_Month|Date|_Group|Item Code|Item Name|Sale Order No|Task Name|Emp ID|Full Name|Labour Price|Quantity|Amount'
                        format='0|0|0|0|0|0|1|0|0|0|1|1'
                        aligns='0|0|1|0|0|0|1|1|0|1|0|0'
                        defaults='|||||||||||'
                        editcol='0|0|0|0|0|0|0|0|0|0|0|0'
                        widths='0|1200|1215|2500|1300|1225|1200|1000|2010|1125|1000|1000'
                        sorting='T'
                        styles='width:100%; height:100%'
                        /> 
  				</td>
  			</tr>
		</table>
	</td>		
</tr>	

</table>
<gw:textbox id="txtEmp_PK"  styles="display:none"/>
<gw:textbox id="txtItem_PK"  styles="display:none"/>
<gw:textbox id="txtGroup_Special"  styles="display:none"/>
<gw:textbox id="txtMonth"  styles="display:none"/>
</body>
</html>
