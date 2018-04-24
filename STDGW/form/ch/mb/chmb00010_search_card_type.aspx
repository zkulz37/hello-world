<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser("hr")%>
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
var idcode = "<%=Request.querystring("idcode")%>";
function BodyInit()
{ 	
    grdCategory.GetGridControl().ScrollTrack=true;
    grdCategory.GetGridControl().FrozenCols =5;
    if (v_language!="ENG")
        System.Translate(document);
     iduser_pk.text = "<%=session("USER_PK")%>";
     txtHr_level.text= "<%=session("HR_LEVEL")%>";
    
    v_idcode.text = idcode;
	if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	{
        datUser_info.Call();     	    
	}

    var con = grdCategory.GetGridControl();
	con.ColFormat(3) = "###,###,###,###,###"; 
	
    datCategoryBiz.Call("SELECT");
}
//--------------------------------------
function OnSelect()
{
    OnExit();
}
//------------------------------------------
function OnExit()
{
    var obj= Array();
    var irow;
    irow=grdCategory.row;
    if (irow>0) 
    {
        obj[0]=grdCategory.GetGridData(irow,0); //Type PK
        obj[1]=grdCategory.GetGridData(irow,2); //Type Name
    }    
    else 
    {
        obj=null;
    }
	window.returnValue = obj; 
	window.close();
}
</script>
<body bottommargin="0" topmargin="0" leftmargin="0" rightmargin="0" >

<gw:data id="datCategoryBiz"> 
    <xml> 
        <dso  type="grid" function="hr.sp_sel_category_biz_card"> 
            <input> 
                <input bind="v_idcode" /> 
            </input> 
            <output bind="grdCategory" /> 
        </dso> 
   </xml> 
</gw:data> 

<table style='margin-left:10px' align = top class="itable" cellspacing=0 cellpadding=0 border=1 style="width:100%;height:100%;" >
	<tr align = top> 
	    <td align = top  width="100%" style="height:93%" >
  		    <gw:grid   
			    id="grdCategory"  
			    header='_PK|Type ID|Type Name|Amount|Currency|_Code'
                format='0|0|0|0|0|0'
                aligns='0|0|0|3|0|0'
                defaults='||||||'
                editcol='1|1|1|1|1|1'
                widths='0|1500|2500|2000|2500|0'
                sorting='T'
                styles='width:100%; height:100%'
			    oncelldblclick ="OnSelect()" /> 
  	    </td>
    </tr>
</table>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="v_idcode" styles="display:none"/>
</body>
</html>

				
