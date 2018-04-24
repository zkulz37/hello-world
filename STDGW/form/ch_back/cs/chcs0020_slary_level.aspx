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
    //grdSalary.GetGridControl().ScrollTrack=true;
    if (v_language!="ENG")
        System.Translate(document);
	txt_PK.text="<%=request.QueryString("pk")%>";
	txt_option.text="<%=request.QueryString("option")%>";
	datAllowance.Call("SELECT");
	
}


function OnDataReceive(obj)
{
    if (obj.id=="datAllowance")
   {
        var icol=5; //value of allowance col
        grdSalary.SetGridText(0,icol,grdAllowance.GetGridData(1,0));
        grdSalary.SetGridText(0,icol+1,grdAllowance.GetGridData(1,1));
        grdSalary.SetGridText(0,icol+2,grdAllowance.GetGridData(1,2));
        grdSalary.SetGridText(0,icol+3,grdAllowance.GetGridData(1,3));
        grdSalary.SetGridText(0,icol+4,grdAllowance.GetGridData(1,4));
        grdSalary.SetGridText(0,icol+5,grdAllowance.GetGridData(1,5));
        grdSalary.SetGridText(0,icol+6,grdAllowance.GetGridData(1,6));
        grdSalary.SetGridText(0,icol+7,grdAllowance.GetGridData(1,7));
        grdSalary.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,8)));
        grdSalary.GetGridControl().ColHidden(icol+1)=!(Number(grdAllowance.GetGridData(1,9)));
        grdSalary.GetGridControl().ColHidden(icol+2)=!(Number(grdAllowance.GetGridData(1,10)));
        grdSalary.GetGridControl().ColHidden(icol+3)=!(Number(grdAllowance.GetGridData(1,11)));
        grdSalary.GetGridControl().ColHidden(icol+4)=!(Number(grdAllowance.GetGridData(1,12)));
        grdSalary.GetGridControl().ColHidden(icol+5)=!(Number(grdAllowance.GetGridData(1,13)));
        grdSalary.GetGridControl().ColHidden(icol+6)=!(Number(grdAllowance.GetGridData(1,14)));
        grdSalary.GetGridControl().ColHidden(icol+7)=!(Number(grdAllowance.GetGridData(1,15)));
        dat_salary_level.Call();
   }
    else if (obj.id=="dat_salary_level")
   {
        for(var i=1;i<grdSalary.rows;i++)
        {   if((grdSalary.GetGridData(i,0)+"")==txt_PK.text)
            grdSalary.SetCellBgColor(i, 0,i, grdSalary.cols-1, 0xcc99ff);
        }
        auto_resize_column(grdSalary,0,grdSalary.GetGridControl().cols-1,10);
   }
}
//---------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
function onPrint(obj)
{
    obj.GetGridControl().PrintGrid("Salary History Modified",true,1,0,360);
}
function OnSelect()
{ var obj= Array();
    var irow;
    irow=grdSalary.row;
    if (irow>0) 
    {
     obj[0]= grdSalary.GetGridData(irow,0)+""  ;
     obj[1]= grdSalary.GetGridData(irow,4)+""  ;
     obj[2]= grdSalary.GetGridData(irow,5) +"" ;
     obj[3]= grdSalary.GetGridData(irow,6) +"" ;
     obj[4]= grdSalary.GetGridData(irow,7) +"" ;
     obj[5]= grdSalary.GetGridData(irow,8) +"" ;
     obj[6]= grdSalary.GetGridData(irow,9) +"" ;
     obj[7]= grdSalary.GetGridData(irow,10) +"" ;
     obj[8]= grdSalary.GetGridData(irow,11) +"" ;
     obj[9]= grdSalary.GetGridData(irow,12) +"" ;
     
    }
    else 
    {
        obj=null;
    }
    
	window.returnValue = obj; 
	window.close();
}
</script>
<body>
<gw:data id="dat_salary_level" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="" function="HR.sp_group_salary"> 
                <input bind="grdSalary" >
                 <input bind="txt_PK" />
                 <input bind="txt_option" />                 
                    </input>
                <output  bind="grdSalary" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------>
<gw:data id="datAllowance" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="hr.sp_sel_allowance_salary" > 
                <input bind="grdAllowance" >
                </input>
                <output  bind="grdAllowance" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------>
<table align = top style='margin-left:10px' class="itable" cellspacing=0 cellpadding=0 border=0 style="width:100%;height:100%;">
<tr>
	<td> 	
	    <table width="100%" height=7% cellspacing=0 cellpadding=0 >		
			<tr>
				<td align ="center" width=90%>TABLE SALARY </td>
				<td  width="10%" align="center"><gw:imgBtn img="printer" id="ibtnSearch2"   alt="Print"  onclick="onPrint(grdSalary)"/></td>
  			</tr>
		</table>
		<table width="100%" height=93% border=1 cellspacing=0 cellpadding=0 >		
			<tr>
				<td align = top height=100% >					
					<gw:grid   
                        id="grdSalary"  
                        header="_PK|Group Salary Name|_ID|_Level|Basic salary|Allow1|Allow2|Allow3|Allow4|allow5|Allow6|Allow7|Allow8|Remark"
                        format="0|0|0|0|1|1|1|1|1|1|1|1|1|0"
                        aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                        defaults="|||||||||||||"
                        editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                        widths="0|2000|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500"
                        styles="width:100%; height:100%" 
                        sorting="T"  
                         oncelldblclick ="OnSelect()" /> 
                        /> 
  				</td>
  			</tr>
		</table>
	</td>		
</tr>	

</table>
<gw:textbox id="txt_PK"  styles="display:none"/>
<gw:textbox id="txt_option" text='1' styles="display:none"/>
 <gw:grid   
    id="grdAllowance"  
    header="Code Name 1|Code Name 2|Code Name 3|Code Name 4|Code Name 5|Code Name 6|Code Name 7|Code Name 8|Display 1|Display 2|Display 3|Display 4|Display 5|Display 6|Display 7|Display 7"
    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
    aligns="0|2|2|1|0|0|1|1|2|1|0|0|0|0|0|0"  
    defaults="||||||||||||||"  
    editcol="0|0|0|0|0|1|1|1|1|1|0|0|0|0|0|0"  
    widths="0|1500|1600|1000|2500|1500|1700|1500|1700|1500|1500|1200|1200|1200|1200|1200"  
    styles="display:none" 
    sorting="T"    
/> 
</body>
</html>
