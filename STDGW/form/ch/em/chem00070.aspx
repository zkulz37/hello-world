<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
 <html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
var lang= "<%=Session("Lang")%>"; 
var mousex,mousey;
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document); 
    txtEmp_PK.text="<%=session("EMPLOYEE_PK")%>";  
    txtCompany_PK.text="<%=session("COMPANY_PK")%>";
    txtLang.text="<%=session("SESSION_LANG")%>";     
    ls_data = "<%=ESysLib.SetListDataSQL("SELECT PK, EVA_YYYY ||' - ' || EVA_SEQ FROM THR_EVA_MASTER WHERE DEL_IF=0 and NVL(CLOSE_YN,'N')='N' order by 2 desc")%>";
    lstYear.SetDataText(ls_data); 
    ls_eva_grp_data="<%=ESysLib.SetListDataSQL("select a.pk, a.GROUP_ID|| '-' || a.GROUP_NM from THR_EVA_GROUP a where a.DEL_IF=0")%>"
    ls_eva_grp_data=ls_eva_grp_data+"|ALL|Select All"
    lstEvaGrp.SetDataText(ls_eva_grp_data);
    lstEvaGrp.value="ALL";
    <%=ESysLib.SetGridColumnComboFormat( "idGrid" , 7 ,  "select code,CODE_NM from vhr_hr_code where id='HR0112' order by code_nm ") %>; 
    imgEmp.SetEnable(0); 
    lstEvaGrp.SetEnable(0);
    SetGridFormat();
    dat_get_emp_info_chem00060.Call();
    
    
}
function IsNumeric(sText)
{
   var ValidChars = "0123456789.";
   var Char;

   for (i = 0; i < sText.length; i++) 
   { 
      Char = sText.charAt(i); 
      if (ValidChars.indexOf(Char) == -1) 
      {
         return false;
      }
   }
   return true;
}

function SetGridFormat()
{
       if(idGrid.rows <2)
       {
            idGrid.AddRow();
       } 
        var fg=idGrid.GetGridControl();
		//set bold
		fg.Cell(13, 0, 0, 0, fg.Cols-2) = true;
		fg.Cell(13, 0, 0, 1, fg.Cols-2) = true;
		
        fg.FixedRows = 2;
        fg.MergeCells = 5;
		fg.MergeRow(0) = true;

		fg.MergeCol(0) = true;
		fg.Cell(0, 0, 0, 1, 0) = "Type";
		
		fg.MergeCol(1) = true;
        fg.Cell(0, 0, 1, 1, 1) = "Element";
		fg.MergeCol(2) = true;
		fg.Cell(0, 0, 2, 1, 2) = "E.Weight";
		fg.MergeCol(3) = true;
        fg.Cell(0, 0, 3, 1, 3) = "MBO Plan";
        fg.MergeCol(4) = true;
        fg.Cell(0, 0, 4, 1, 4) = "MBO Result";
		fg.MergeCol(5) = true;
		fg.Cell(0, 0, 5, 1, 5) = "Weight";
		fg.Cell(0, 0, 3, 0, 5) = "MBO";
		fg.Cell(0, 0, 6, 0, 10) = "Indicator";  		
		fg.Cell(0, 1, 6, 1) = "Description";
		fg.Cell(0, 1, 7, 1) = "Unit";
		fg.Cell(0, 1, 8, 1) = "Current";
		fg.Cell(0, 1, 9, 1) = "Target";	
		fg.Cell(0, 1, 10, 1) = "Result";	
		
		//fg.MergeCol(17) = true;
		//fg.Cell(0, 0, 17, 1, 17) = "Score";
		
		fg.ColWidth(0)=700;
		fg.ColWidth(1)=2000;
		fg.ColWidth(2)=1000;
		fg.ColWidth(3)=4000;
		fg.ColWidth(4)=5000;
		fg.ColWidth(5)=900;
		fg.ColWidth(6)=2000;
		fg.ColWidth(7)=800;
		fg.ColWidth(8)=800;
		fg.ColWidth(9)=800;
		fg.ColWidth(10)=800;
		fg.ColWidth(11)=800;
		fg.ColAlignment(0) = flexAlignCenterCenter;
		fg.ColAlignment(1) = flexAlignLeftCenter;
		fg.ColAlignment(4) = flexAlignLeftCenter;
		fg.ColAlignment(5) = flexAlignRightCenter;		
		fg.ColAlignment(6) = flexAlignLeftCenter;		
		fg.ColAlignment(7) = flexAlignCenterCenter;
		fg.ColAlignment(8) = flexAlignRightCenter;		
		fg.ColAlignment(9) = flexAlignRightCenter;		
		fg.ColAlignment(10) = flexAlignRightCenter;		
		fg.ColAlignment(17) = flexAlignRightCenter;
}
function merge()
{
    var ctr = idGrid.GetGridControl();
    ctr.MergeCells = 4;
    ctr.MergeCol ( 0 ) = true;
    ctr.MergeCol ( 1 ) = true;
    ctr.MergeCol ( 2 ) = true;
    ctr.MergeCol ( 3 ) = false;
    ctr.MergeCol ( 4 ) = false;
    ctr.MergeCol ( 5 ) = false;
}
function ChoseList_box(obj_list,value)
{    
    obj_list.SetDataText(value);
    obj=obj_list.GetControl()
	if (obj.options.length ==2)
		obj.options.selectedIndex=0;
	else
		obj.options.selectedIndex=obj.options.length-1; 
}
function checkdata()
{
    var i;
    var ctrl=idGrid.GetGridControl();
    
    for (i=2;i<idGrid.rows;i++)
    {        
        if(idGrid.GetGridData(i,0) == "C") continue;
        
        if(IsNumeric(idGrid.GetGridData(i,10))== false)
        {
            alert("Value of result must be number at row "+ (i-1));
            return false;
        }
        if(IsNumeric(idGrid.GetGridData(i,17))== false)
        {
             alert("Value of score must be number at row "+ (i-1));
            return false;
        }
        else if ((idGrid.GetGridData(i,17)>100) || (idGrid.GetGridData(i,17)<0))
        {
            alert("Score must be between 0 and 100 at row "+(i-1));
            return false;
        }               
    }
     return true;
}
function OnDataReceive(obj)
{    
    if (obj.id=="dat_get_emp_info_chem00060")
    {              
        imgEmp.SetDataText(txtPhoto_PK.text);   
        datchem00050_1.Call();    
    }
   
    if (obj.id=="datchem00050_1")
    {        
        datchem00070_4.Call();        
    }
    if (obj.id=="datchem00070_4")
    {       
        ChoseList_box(lstEvaGrp,txtGroupEval.text);
        datchem00060_1.Call();       
    }
    if  (obj.id=='datchem00060_1')
    {
         ChoseList_box(lstFactor,txtGroupFactor.text);  
         lstFactor.value='ALL'; 
         OnSearch();
    }
    if  (obj.id=='datchem00070')
    {
        SetGridFormat();
        merge();
        if (idGrid.rows > 2)
        {
            if (idGrid.GetGridData(2,15) == 'C')
            {                
                ibtnConfirm.SetEnable(false);
                ibtnSave.SetEnable(false);
            }
            else 
            {                
                ibtnConfirm.SetEnable(true);
                ibtnSave.SetEnable(true);
            }
        }
    }
}
function OnSearch()
{    
    datchem00070.Call("SELECT");
}
function OnSave()
{
    datchem00070.Call();
}
function CheckDataIsValid(){
    for (var i=2;i<idGrid.rows;i++)
       {
            if(idGrid.GetGridData(i,0) == "C") continue;
            
            if (idGrid.GetGridData(i,4) == "")
            {
                alert("Please input mbo result at row "+ (i-1));
                return false;
            }
            if (idGrid.GetGridData(i,10) == "")
            {
                alert("Please input result at row "+ (i-1));
                return false;
            }
            else if (idGrid.GetGridData(i,17) == "")
            {
                alert("Please input score at row "+ (i-1));
                return false;
            }
            else if (Number(idGrid.GetGridData(i,19)) > 100 || Number(idGrid.GetGridData(i,19)) < 0 )
            {
                alert("Please check score at row "+ (i-1) +" .(Score must be between 0 and 100).");
                return false;
            }
       } 
       return true;
}
function OnConfirm()
{        
    if(confirm('Are you sure you want to confirm?'))
    {       
        if (CheckDataIsValid())
        {
            for(var i=2;i<idGrid.rows;i++){
                idGrid.SetGridText(i,15,'C');
            }
            datchem00070.Call();  
        }
    }   
}

function onCellClickToGrid()
{
    if(event.row <2) return;
    
    if((idGrid.GetGridData(event.row,15) == 'C') || (idGrid.GetGridData(event.row,0) == 'C') 
    && (event.col != 3) && (event.col != 4)){
      idGrid.row = -1;
      return;
    }
}
function onOpenPopup()
{
    var write_yn="";
    if((idGrid.GetGridData(event.row,15) == 'C') || (idGrid.GetGridData(event.row,0) == 'C')) {
        write_yn = "N";
    }
    else{
        write_yn = "Y";
    }
    
    if (event.col == 3 || event.col == 4)
    {
        var path = System.RootURL + '/form/ch/em/chem00060_2.aspx?write_yn='+write_yn;
        var object = System.OpenModal(path ,700 , 500 , 'resizable:yes;status:yes',window);
        
        if(object!=null)
        {
			idGrid.SetGridText(idGrid.row,4,object[0]);
		}	
    }    
}
function GetMBO(){
    return idGrid.GetGridData(idGrid.row,3);
}
function GetMBOResult(){
    return idGrid.GetGridData(idGrid.row,4);
}
function OnGridCellClick(index)
{
    //do nothing 
}
function FindPos( obj , posinfo )
{

	var pobj ;
	
	var x = 0  , y = 0 ;
	
	
	pobj = obj;
	
	while ( pobj )
	{
		x += pobj.offsetLeft;
		y += pobj.offsetTop;
		
		// alert( pobj.offsetLeft + "="+pobj.outerHTML );
		
		if ( pobj != obj && pobj.offsetParent && pobj.tagName != "TABLE")
		{
			// alert( pobj.clientLeft + ":" + pobj.clientTop + "/" + pobj.offsetLeft + "="+pobj.outerHTML);
			x += pobj.clientLeft;
			y += pobj.clientTop;
			
		}
		pobj = pobj.offsetParent;	
	}

	
	posinfo.x = x;
	posinfo.y = y;
	posinfo.width = obj.offsetWidth;
	posinfo.height = obj.offsetHeight;
}

</script>
<body bgcolor='#F5F8FF'>
<!------------------------------------------------------>
<gw:data id="dat_get_emp_info_chem00060" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_pro_chem00060_01" > 
                <input>
                    <input bind="txtEmp_PK" />
                </input> 
                <output>                    
                    <output bind="txtName"/>
                    <output bind="txtDept" />          
                    <output bind="txtGroup" />
                    <output bind="txtPhoto_PK" />
                    <output bind="txtPos" /> 
                    <output bind="txtPos_Time" />                                                                
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datchem00050_1" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_pro_chem00050_1" > 
                <input>
                    <input bind="lstYear" /> 
                    <input bind="txtCompany_PK" />                    
                </input> 
                <output>
                    <output bind="txtEvalPeriod" />
                    <output bind="txtSchedule" />
                    <output bind="txtGradeEvatype" />
                    <output bind="txtGradeEvatimes" />  
                    <output bind="txtEmpTotal" />                                     
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datchem00060_1" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="HR_pro_chem00060_1" > 
                <input>
                    <input bind="lstEvaGrp" /> 
                </input> 
                <output>
                    <output bind="txtGroupFactor" />                                     
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datchem00070_4" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="HR_pro_chem00060_4" > 
                <input>
                    <input bind="txtEmp_PK" /> 
                    <input bind="lstYear" />
                </input> 
                <output>
                    <output bind="txtGroupEval" /> 
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datchem00070" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="4,10,11,12,15,17,18" function="HR_sel_chem00070" procedure="HR_upd_chem00070" > 
                <input bind="idGrid">
                    <input bind="lstYear"/>  
                    <input bind="lstFactor"/>   
                    <input bind="txtEmp_PK" /> 
                    <input bind="txtLang" />                                    
                </input>
                <output bind="idGrid"/>
            </dso>
        </xml>
    </gw:data>     

<!----------------------------------->
<table id="main" cellpadding="0" cellspacing="0" border=0 style="width:100%;height:100%; margin-left:0; margin-top:0">
<tr>
    <td style="width:58%;height:34%">
    <fieldset style="padding: 5;height:100%"><legend>Employee infomation</legend>
        <table border=0 cellpadding=0 cellspacing=0 style="width:100%">
            <tr>
				<td width="25%">
                    <gw:image id="imgEmp" view="/binary/ViewFile.aspx" post="/binary/PostFile.aspx" styles="width:130;height:130; border-top: 1 solid #87b0c6; border-bottom: 1 solid #87b0c6; border-left: 1 solid #87b0c6; border-right: 1 solid #87b0c6"/>
                </td> 
                <td width="5%">&nbsp;</td>
              
                <td width="75%">
                    <table width="100%" border="0">
                        <tr>
                        	<td align="right">Evaluation #&nbsp;</td>
                            <td><gw:list id="lstYear"  onchange="datchem00050_1.Call()"/></td>
                        </tr>
                        <tr>
                        	<td align="right">Evaluation Period&nbsp;</td>
                            <td><gw:label id="txtEvalPeriod"  text="" 	maxlen = "20" styles='border-width:1;width:100%;'/></td>
                        </tr>
                        <tr>
                        	<td align="right">Schedule &nbsp;</td>
                            <td><gw:label id="txtSchedule"  text="01-Apr-2008 ~ 15-Apr-2009" 	maxlen = "20" styles='border-width:1;width:100%;'/></td>
                        </tr>
                        <tr>
                            <td colspan="2"><gw:label id="txtName"  text=""  styles='border-width:1;width:100%;'/></td>
                        </tr>
                        <tr>
                        	<td><gw:label id="txtDept"  text="" styles='border-width:1;width:100%;'/></td>
                            <td><gw:label id="txtGroup"  text="" styles='border-width:1;width:100%;'/></td>
                        </tr>
                        <tr>
                        	<td><gw:label id="txtPos"  text="" styles='border-width:1;width:100%;'/></td>
                            <td><gw:label id="txtPos_Time"  text="" styles='border-width:1;width:100%;'/></td>
                        </tr>
                       <!-- <tr>
                        	<td colspan="2"><gw:label id="txtTemp"  text="ADDITIONAL INFO..." styles='width:100%;'/></td>
                        </tr>-->
                    </table>
                </td>
            </tr>
		 </table>
     </fieldset>
    </td>
    <td style="width:2%">&nbsp;</td>
    <td style="width:40%">
    <fieldset style="padding: 5;height:82%"><legend>Evaluation Group Infomation</legend>
        <table border=0 cellpadding=3 cellspacing=0 style="width:100%" height="100%">
			<tr style="height:10%">
            	<td style="width:30%"></td>
                <td style="width:70%"></td>
            </tr>
            <tr style="height:10%">
                <td nowrap align="right">Evaluation Group</td>
                <td align=left><gw:list id="lstEvaGrp"  onchange="datchem00060_1.Call()"/></td>
            </tr>
                    
            <tr style="height:10%">                 
                <td align="right"><gw:icon id="ibtnSave" alt="Save"  text="Save"  img="in"  styles="width:10%" onclick="OnSave()"/></td>
                <td align="left"> <gw:icon id="ibtnConfirm" alt="Confirm"  text="Confirm"  img="in"  styles="width:10%" onclick="OnConfirm()"/></td>
                <td nowrap>&nbsp;</td>
            </tr>
            <tr style="height:60%">
            	<td align="right" colspan=2></td>                    
            </tr>
        </table>
      </fieldset>
    </td>
    </tr>
    <tr>
        <td colspan=3 style="height:1%">&nbsp;</td>
    </tr>    
    <tr>
        <td style="width:100%;height:60%" colspan=3>
            <gw:grid   
            id="idGrid" 
            header="Type|Element|E.Weight|MBO Plan|MBO Result|MBO Weight|Indication|Unit|Present|Target|Result|_thr_eva_master_pk|_thr_eva_emp_pk|_OpinonEva|_OpnionAssignPos|_p_status|_lang|Score|_PK"                                       
            format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
            aligns="0|1|1|0|0|0|0|0|0|1|0|0|0|0|0|0|0|0|0"    
            defaults="||||||||||||||||||"                     
            editcol="0|0|0|0|1|0|0|0|0|0|1|1|1|0|0|1|0|1|0"  
            widths="0|2000|2000|4000|4000|1500|1500|800|0|0|0|0|0|0|0|1000|0|0|0"
            styles="width:100%; height:100%" editcolcolor="true"
            acceptNullDate="T" oncellclick="onCellClickToGrid()" onafteredit="checkdata()" oncelldblclick="onOpenPopup()"            
            sorting="T"
            /> 
        </td>    
    </tr>
</table>
<gw:textbox id="txtEmp_PK" style="display:none" />
<gw:textbox id="txtPhoto_PK" style="display:none" />
<gw:textbox id="txtGradeEvatype" style="display:none" />
<gw:textbox id="txtGradeEvatimes" style="display:none" />
<gw:textbox id="txtEmpTotal" style="display:none" />
<gw:textbox id="txtGroupEval" style="display:none" />
<gw:textbox id="txtGroupFactor" style="display:none" />
<gw:textbox id="txtCompany_PK" style="display:none" />
<gw:textbox id="txtLang" style="display:none" />
<gw:textarea id="txtOpinionEval" rows=5 text="" onchange="" styles='width:100%;display:none'/>
<gw:textarea id="txtOpinionAssign" rows=5 text="" onchange="" styles='width:100%;display:none'/>
<gw:list id="lstFactor" value="ALL" style="display:none"/>
</body>



