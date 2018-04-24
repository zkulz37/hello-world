<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml" >
<head >
    <title>Change Budget Period</title>
</head>
<%  ESysLib.SetUser("acnt")%>
<script>
function BodyInit()
{
      System.Translate(document);
}      
</script>
<body>
       <table cellpadding="0" cellspacing="0" style="width:100%;height:100%">
            <tr style="height:2%">
                            <td width="100%">
                                            <fieldset style="padding:0">
                                                        <table cellpadding="0" cellspacing="0" width="100%">
                                                                    <tr>
                                                                                    
                                                                                    <td align="right" width="10%"><a title="Click here to show Project" href="#" style="text-decoration : none" onClick="OnPopUp('Project')">Project&nbsp;</a></td>
                                                                                    <td width="60%">
                                                                                            <table cellpadding="0" cellspacing="0" width="100%">
                                                                                                    <tr>
                                                                                                                <td width="40%"><gw:textbox id="txtProject_Cd" readonly="true" styles='width:100%' /></td>
                                                                                                                <td width="60%"><gw:textbox id="txtProject_Nm" readonly="true" styles='width:100%' /></td> 
                                                                                                                <td width=""><gw:textbox id="txtProject_Pk" styles='width:100%;display:none' /></td>  
                                                                                                                <td ><gw:imgbtn id="btve2" img="reset" alt="Reset"  onclick="txtProject_Cd.text='';txtProject_Nm.text='';txtProject_Pk.text='';" /></td> 
                                                                                                    </tr>
                                                                                            </table>
                                                                                    </td>
                                                                                    <td align="right" width="25%">Working Period&nbsp;</td>
                                                                                    <td><gw:datebox id="dtWorkingPeriod_Fr" lang="1"  /></td>
                                                                                    <td>~</td>
                                                                                    <td width=""><gw:datebox id="dtWorkingPeriod_To" lang="1"  /></td> 
                                                                                    <td width="5%"></td>
                                                                                    <td ><gw:imgBtn id="ibtnUpdte" img="search" alt="Search" 	onclick="OnSearch()" 	 /></td>  
                                                                                    <td ><gw:imgBtn id="ibtnpdte" img="new" alt="New" 	onclick="OnNew()" 	 /></td>  
                                                                                    <td ><gw:imgBtn id="ibtnUpdate" img="save" alt="Save" 	onclick="OnSave()" 	 /></td> 
                                                                                    <td ><gw:imgBtn id="ibtUpdate" img="delete" alt="Delete" 	onclick="OnDelete()" 	 /></td> 
                                                                                    <td ><gw:imgBtn id="ibtnUdate" img="udelete" alt="UnDelete" 	onclick="OnUnDelete()" 	 /></td> 
                                                                                    <td ><gw:imgBtn id="ibtndate" img="confirm" alt="Confirm" 	onclick="OnConfirm()" 	 /></td>  
                                                                    </tr>
                                                        </table>
                                            </fieldset>
                            </td>
            </tr>
            <tr style="height:98%">
                        <td colspan="4">
                                    <gw:grid   
                                                    id="Grid_Detail"  
                                                    header="Work Date|Working Period  (Start Date)|Working Period  (Finish Date)|Change Reason|Confrim Y/N"   
                                                    format  ="0|0|0|0|0"  
                                                     aligns  ="1|1|0|0|1"  
                                                    defaults="||||"  
                                                    editcol ="1|1|1|1|1"  
                                                    widths  ="1200|2700|2700|3000|1000"  
                                                    styles="width:100%; height:100%"   
                                                    sorting="T"
                                                     /> 
                        </td>
            </tr> 
           
  </table>

</body>
</html>
