<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Evaluation Result Inquiry</title>
    <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
</head>

<script>
var l_byhand=19;
var l_close=20;
function BodyInit()
{
    var data="";
    data = "<%=ESysLib.SetListDataSQL("SELECT pk, org_nm  FROM tco_org WHERE del_if = 0 order by 2" )%>|ALL|Select all";    
    lstOrg_Code.SetDataText(data);
    lstOrg_Code.value="ALL";
    data = "<%=ESysLib.SetListDataSQL("SELECT a.pk, a.GROUP_ID || '-' || a.group_nm FROM thr_eva_group a WHERE a.del_if = 0")%>|ALL|Select all"; 
    lstEvaluationGrp.SetDataText(data);
    lstEvaluationGrp.value="ALL";

    data = "<%=ESysLib.SetListDataSQL("select pk,EVA_YYYY ||'-'|| EVA_SEQ from thr_eva_master where del_if=0 order by 2 desc")%>";    
    lstEvaMaster.SetDataText(data);    

    data="#Y;Yes|#N;No";
    idGrid.SetComboFormat(l_byhand,data);//byhand
   
    idGrid.GetGridControl().FrozenCols = 5;
    
}

function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}

function OnSearch()
{
    dsql_chem00180.Call("SELECT");
    
}




function OnDataReceive(obj)
{
   if(obj.id == "dsql_chem00180")
   {
       lblRecord_M.text = idGrid.rows-1  + " Row(s)" ; 
       auto_resize_column(idGrid,0,idGrid.cols-1,0);    
       if(idGrid.rows-1>0)
       {
            if(idGrid.GetGridData(1,l_close)=='Y')
                btnSave.SetEnable(0);
            else
                btnSave.SetEnable(1);
                
       }
       else 
            btnSave.SetEnable(0);

    
    }
    
}




 function OnShowPopup()
{     
        var strcom;
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        //var obj  = System.OpenModal(  fpath , 300 , 200 , 'resizable:yes;status:yes');
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+window.event.screenY+';edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {  
			lstOrg_Code.value = obj;
           
			
            
        }
}
function OnSave()
{
    if(confirm("Do you want to save?"))
        dsql_chem00180.Call();
}
</script>

<body>
    <gw:data id="dsql_chem00180" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" parameter="0,1,16,17,18,19" function="sp_sel_chem00180" procedure="sp_upd_chem00180">  
                    <input bind="idGrid">  
                    <input bind="lstEvaMaster" />
                    <input bind="lstOrg_Code" />
                    <input bind="lstEvaluationGrp" />  
                    <input bind="txtEmployee" /> 
                </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>

   
    <table style="width: 100%; height: 100%">
        <tr>
            <td>
                <table style="width: 100%; height: 100%">
                    <tr style="height: 2%" valign="top">
                        <td>
                            <fieldset>
                                <table style="width: 100%; height: 100%">
                                    <tr>
                                        <td width="5%"><a title="Click here to show Organization" onclick="OnShowPopup()" href="#tips" >Oganization</a>
                                        </td>
                                        <td width="28%">
                                            <gw:list id="lstOrg_Code" onchange="" />
                                        </td>
                                        <td width="5%">
                                            Eva.Term
                                        </td>
                                        <td width="10%">
                                            <gw:list id="lstEvaMaster" onchange="" styles="width:100px" />
                                        </td>
                                        <td width="5%">
                                            Eva.Group</td>
                                        <td width="15%">
                                            <gw:list id="lstEvaluationGrp" onchange="" />
                                        </td>
                                        <td width="5%">
                                            Employee</td>
                                        <td width="11%">
                                            <gw:textbox id="txtEmployee" onenterkey="OnSearch()" />
                                        </td>
                                        
                                        <td style="width: 9%" align="center">
                                            <gw:label id="lblRecord_M" style="font-weight: bold; color: red; font-size: 12" text="0 row(s)" />
                                        </td>
                                        <td with="2%">
                                            <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
                                        </td>
                                         <td width="2%">&nbsp;</td>
                                        <td width="2%">
                                            <gw:imgbtn id="btnSave" img="Save" alt="Save" onclick="OnSave()" />
                                        </td>
                                       
                                    </tr>
                                </table>
                               
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="height: 98%" valign="top">
                        <td>
                            <table style="width: 100%; height: 100%" border="1">
                                <tr style="height: 100%">
                                    <td>
                                        <gw:grid id="idGrid" 
                                            header="_Eva_pk|_emp_pk|Organization|Emp ID|Full Name|Join Date|Job Title|Evaluation Group|First Reviewer|Second Reviewer|A-Score|A-Rank|A-Grade|C-Score|C-Rank|C-Grade|T-Score|T-Rank|T-Grade|By Hand|_close" 
                                            format="0|0|0|0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|2|0" 
                                            aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                                            defaults="||||||||||||||||||||" 
                                            editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|1|1|1|0" 
                                             widths="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                                            sorting='T' styles="width:100%; height:100%" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txtEva_Emp_PK" styles="display:none" />
    <gw:list id="lstEvaluator" onchange="OnSearch()" styles="display:none" />
</body>
</html>
