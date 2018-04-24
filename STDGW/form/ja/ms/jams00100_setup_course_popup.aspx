<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser("crm")%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Setup Course Infornation</title>
</head>
<%ESysLib.SetUser("crm")%>
<script>
function BodyInit()
{   
	//txtTitle.text="SETUP  COURSE  INFORMATION";
	dso_UpdateCourse.Call("SELECT");
}
function OnSave()
{
      dso_UpdateCourse.StatusUpdate();
	  dso_UpdateCourse.Call();  
 }
 function OnDataReceive(obj)
 {
	if(obj.id=='dso_UpdateCourse')
	{
		
	}
 }
</script>

<body bgcolor='#F5F8FF'>
	 <gw:data id="dso_UpdateCourse" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" parameter="0,2,3" function="crm.sp_sel_jams00100_setup_course" procedure="crm.sp_upd_jams00100_setup_course">  
                <input bind="grdUpdateCourse"   >  
                    <input bind="txtNotParamater" />	
                </input> 
                <output bind="grdUpdateCourse" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table style="width: 100%; height: 100%">
        <tr>
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        
                        <td style="width: 97%" align="center" >
                            <a style="color: #0000ff;">SETUP  COURSE  INFORMATION</a>
                        </td>
                        <td style="width: 3%">
                            <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave()" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="2">
                            <gw:grid id='grdUpdateCourse' header='_PK|TeeBox|Slop Rating|Course Rating|Create By|Create Date|Modify By|Modify Date'
                                format='0|0|0|0|0|0|0|0' 
								aligns='0|0|0|0|0|0|0|0' 
								defaults='|||||||'
                                editcol='0|0|1|1|0|0|0|0' 
								widths='0|0|0|0|0|0|0|0' 
								autosize="T"
                                sorting='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
	<gw:textbox id="txtNotParamater" styles="width:100%;display:none" />
</body>
