<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Evaluation Factor Entry</title>
</head>

<script>

var v_level ='';

//'SEQ|_PK|_THR_EVAGROUP_PK|ELEMENT_TYPE|ELEMENT_NM|WEIGHT|ELEMENT_LNM|ELEMENT_FNM|FACTOR_NM|FACTOR_LNM|FACTOR_FNM|TYPE|USE_YN|_THR_EVA_MASTER_PK'
var c_seq=0,c_pk=1,c_thr_evagroup_pk=2,c_element_type=3;
var c_weigh=5,c_ELEMENT_LNM=6,c_ELEMENT_FNM=7,c_FACTOR_NM=8,c_FACTOR_LNM=9,c_FACTOR_FNM=10,c_TYPE=11,c_USE_YN=12;
var c_THR_EVA_MASTER_PK=13;
var flag_load_sum=true;

function BodyInit()
{   
	var data="";
	data ="#A;Achivement|#C;Competence"; 
	grdFactorEntry.SetComboFormat(c_element_type,data);

	data = "<%=ESysLib.SetListDataSQL("SELECT pk , group_nm from thr_eva_group_v2 where del_if=0 and use_yn='Y'" )%>|ALL|Select All";    
	lstGroup.SetDataText(data);
	
	data = "<%=ESysLib.SetListDataSQL("SELECT pk , group_nm from thr_eva_group_v2 where del_if=0 and use_yn='Y'" )%>|ALL|Select All";    
	lstGroup_to.SetDataText(data);

    data = "<%=ESysLib.SetGridColumnDataSQL("select a.CODE, a.CODE_NM FROM THR_CODE_detail a, thr_code_master b WHERE a.DEL_IF=0 and b.del_if = 0 AND a.thr_code_master_pk = b.pk and b.id = 'HR0219' union all select '','' from dual ")%>";
    grdFactorEntry.SetComboFormat(c_TYPE,data);

	
	OnSearch();
}
function OnSearch()
{
    dsoFactorEntry.Call("SELECT");
}
function OnChangeGroup()
{
    flag_load_sum=true;
    dsoFactorEntry.Call("SELECT");
}
function OnDelete()
{
    grdFactorEntry.DeleteRow(); 
}
function OnNew()
{
    var data="";
    grdFactorEntry.AddRow();
    grdFactorEntry.SetGridText(grdFactorEntry.rows-1,c_thr_evagroup_pk,  lstGroup.GetData());
	grdFactorEntry.SetGridText(grdFactorEntry.rows-1,c_THR_EVA_MASTER_PK,  lstEvaMaster_from.GetData());
}

function OnSave()
{
	if (lstGroup.value =="ALL")
	{
		alert("Please choice group value other ALL");
	}
	else 
	{
		if(CheckDataIsValid())
		{   
            flag_load_sum=true;
			dsoFactorEntry.Call();  
		}
	}
    
 }
function CheckDataIsValid()
{
    for(var i=1;i<grdFactorEntry.rows;i++)
          {
            if(grdFactorEntry.GetGridData(i,0) == "")
             {
                alert("Please input SEQ number at row "+ i);
                return false;
             }
             if(grdFactorEntry.GetGridData(i,c_weigh) == "")
             {
                alert("Please input weight number at row"+i);
                return false;
             }
             else if(grdFactorEntry.GetGridData(i,c_FACTOR_NM) == "")
             {
                alert("Please input factor name  at row"+i);
                return false;
             }
          }
          return true;
}

function CheckSumwieght()
{
  var dValueSum=0;      
    for(i=1; i<grdFactorEntry.rows; i++ )
        dValueSum = Number(dValueSum) + Number(grdFactorEntry.GetGridData(i,c_weigh));
        if(dValueSum != 100)
        {
            alert("sum weight must = 100");
        }
}
function OnDataReceive(obj){
  if(obj.id == "dsoFactorEntry")
    {
		if(flag_load_sum==true)
        {
            flag_load_sum=false;
            dat_chem00020_sum.Call();
        }
	  }
	if (obj.id == "dsoFactorEntry_Copy")
    {
		 if(txtResult.text=="1")
		{
			  alert("Copy Sucssess!");
		 }else if(txtResult.text=="0"){
	
			  alert("Data was already!");
		 }
    }
	if (obj.id == "dsoOnCheck_FactorEva")
    {
		 if(txtResult_2.text=="1")
		{	
		alert("Evaluation of Period already \n Factor chu kỳ này đã tồn tại  !");		
		/*			 
			if(confirm("Evaluation of Period already \n Factor chu kỳ này đã tồn tại  !"))
			{
			set_Interval(100);           
			dsoOnCopy_FactorEva.Call();
			} 
		*/
		}
		
    }	
	if (obj.id == "dsoOnCopy_FactorEva")
    {
		 if(txtResult_2.text=="1")
		{	
		alert("Sucssess.Copy complete! \n Quá trình copy thành công ! ");	
		}
		else 
		{
		alert("Error.Can not copy this data ! \n Lỗi.Quá trình copy không thành công ! ");		
		}
		
    }
	if (obj.id =="datchem00020_lst")
	{
		dat_chem00003.Call();
	}	
    if (obj.id =="dat_chem00003")
	{
        if(txtResult.text=="Y")
        {
		    btnNew.SetEnable(0);
            btnSave.SetEnable(0);
            btnDelete.SetEnable(0);
        }
        else
        {
            btnNew.SetEnable(1);
            btnSave.SetEnable(1);
            btnDelete.SetEnable(1);
        }
	}
	if (obj.id == "datchem00020_lst_2")
	{
		OnCheck_FactorEva();
	}

}

function GetOpinionContent(col)
{
    if(col == c_FACTOR_NM){
        return grdFactorEntry.GetGridData(grdFactorEntry.row, c_FACTOR_NM);
    }
    else if(col == c_FACTOR_LNM){
        return grdFactorEntry.GetGridData(grdFactorEntry.row, c_FACTOR_LNM);
    }
    else if(col == c_FACTOR_FNM){
        return grdFactorEntry.GetGridData(grdFactorEntry.row, c_FACTOR_FNM);
    }
}
function OnGridCellClick(obj)
{
     var content;
    var url=System.RootURL + "/form/ch/em/chem00020_1.aspx?col="+ event.col;   
    switch(event.col)
    {
        case c_FACTOR_NM:
                var winObj = System.OpenModal(url,700,550,"resizable:yes;status:yes", window);
                if ( winObj ){
                    grdFactorEntry.SetGridText(grdFactorEntry.row, c_FACTOR_NM,winObj);
                    
                }
        break;   
       case c_FACTOR_LNM:
                var winObj = System.OpenModal(url,700,550,"resizable:yes;status:yes", window);
                
                if ( winObj ){
                    grdFactorEntry.SetGridText(grdFactorEntry.row, c_FACTOR_LNM,winObj);
                }
        break;      
        case c_FACTOR_FNM:
                var winObj = System.OpenModal(url,700,550,"resizable:yes;status:yes", window);
                
                if ( winObj ){
                    grdFactorEntry.SetGridText(grdFactorEntry.row,c_FACTOR_FNM,winObj);
                 }
             break;   
    }
    
}
function OnCopy()
{
	if(confirm("Are you sure want to copy!"))
		dsoOnCopy_FactorEva.Call(); 
}
function OnCheck_FactorEva()
{	
		dsoOnCheck_FactorEva.Call(); 
}
function Load_Group()
{
    flag_load_sum=true;
    datchem00020_lst.Call();
}
function Load_Group2()
{
    datchem00020_lst_2.Call();
}
</script>

<body bgcolor='#F5F8FF'>
    <!----------------------------------->
    <gw:data id="dat_chem00003"  onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" parameter="" function="" procedure="HR_pro_chem00003_V2">  
                <input>
                     <input bind="lstEvaMaster_from" />  	
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
               
            </dso> 
        </xml> 
    </gw:data>

    <gw:data id="dat_chem00020_sum"  onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" parameter="" function="" procedure="hr_chem00020_sum_v2">  
                <input>
                     <input bind="lstEvaMaster_from" />
                      <input bind="lstGroup" />  
                </input> 
                <output>
                    <output bind="txtSum" />
                    <output bind="lblMBO" />
                    <output bind="lblCapa" />
                    <output bind="lblHr" />
                </output>
               
            </dso> 
        </xml> 
    </gw:data>


    <gw:data id="dsoFactorEntry" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13" function="hr_sel_chem00020_v2" procedure="hr_upd_chem00020_v2">  
                <input bind="grdFactorEntry"   >  
                    <input bind="lstGroup" />  
					<input bind="lstEvaMaster_from" />  					
                </input> 
                <output bind="grdFactorEntry" /> 
            </dso> 
        </xml> 
    </gw:data>
	<!--Check Eva Copy -->
	<gw:data id="dsoOnCheck_FactorEva"  onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" parameter="" function="" procedure="hr_chem00020_CheckEva_v2">  
                <input>
					<input bind="lstGroup"/>
					<input bind="lstEvaMaster_to" />  						
                </input> 
                <output>
                    <output bind="txtResult_2" />
                </output>
               
            </dso> 
        </xml> 
    </gw:data>
	<!--Process Eva Copy -->
	<gw:data id="dsoOnCopy_FactorEva"  onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" parameter="" function="" procedure="hr_chem00020_Copy_v2">  
                <input>
					<input bind="lstGroup"/>
					<input bind="lstEvaMaster_from" />
					<input bind="lstEvaMaster_to" /> 
					<input bind="lstGroup_to" />  					
                </input> 
                <output>
                    <output bind="txtResult_2" />
                </output>
               
            </dso> 
        </xml> 
    </gw:data>
	<gw:data id="datchem00020_lst" onreceive="OnDataReceive(this)"  > 
			<xml> 
				<dso  type="list" procedure="HR_pro_chem00000_v2_grp" > 
					<input>
						<input bind="lstEvaMaster_from"/> 
					</input> 
					<output>
						<output bind="lstGroup" />
					</output>
				</dso> 
			</xml> 
	</gw:data>
		<gw:data id="datchem00020_lst_2" onreceive="OnDataReceive(this)"  > 
			<xml> 
				<dso  type="list" procedure="HR_pro_chem00000_v2_grp" > 
					<input>
						<input bind="lstEvaMaster_to"/> 
					</input> 
					<output>
						<output bind="lstGroup_to" />
					</output>
				</dso> 
			</xml> 
	</gw:data>
	<!------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr>
            <td>
                <table style="width: 100%; height: 100%">
                    <tr tyle="height: 1%">
                        <td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td>
                        <td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td>
                        <td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td>
                        <td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td>
                        <td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td>
                        <td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td>
                        <td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td>
                        <td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td>
                        <td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td>
                        <td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td>
                    </tr>
                    <tr tyle="height: 5%">
                        <td colspan=10 width="10%" style="border:0" align="right" >
                            Eva Group
                        </td>
                        <td colspan=15 width="15%" style="border:0" align="left" >
                            <gw:list id="lstGroup" onchange="OnChangeGroup()" />
                        </td>
						
						
                        <td colspan=15 width="15%" style="border:0" align="left" >
                            <gw:list id="lstEvaMaster_from"  onchange="Load_Group()" >
							<data>
                                <%=ESysLib.SetListDataSQL("SELECT PK , EVA_SEQ FROM (  SELECT PK, EVA_YYYY ||' - ' || EVA_SEQ  AS EVA_SEQ FROM THR_EVA_MASTER WHERE DEL_IF=0 union SELECT 0 AS PK ,'Evaluation#' AS EVA_SEQ   FROM DUAL ) K  order by  EVA_SEQ desc" )%>
                            </data>
							</gw:list>
                        </td>
						 <td colspan=10 width="10%" style="border:0" align="center" >
						 Copy to
                        </td>
						
						<td colspan=10 width="10%" style="border:0" align="right" >
                             Eva Group
                        </td>
                        <td colspan=15 width="15%" style="border:0" align="left" >
                            <gw:list id="lstGroup_to" onchange="OnSearch()" />
                        </td>
						
						 <td colspan=15 width="15%" style="border:0" align="left" >
                            <gw:list id="lstEvaMaster_to"  onchange="Load_Group2()" >
							<data>
                                <%=ESysLib.SetListDataSQL("SELECT PK , EVA_SEQ FROM (  SELECT PK, EVA_YYYY ||' - ' || EVA_SEQ  AS EVA_SEQ FROM THR_EVA_MASTER WHERE DEL_IF=0 and CLOSE_YN='N' union SELECT 0 AS PK ,'Evaluation#' AS EVA_SEQ   FROM DUAL ) K  order by  EVA_SEQ desc" )%>
                            </data>
							</gw:list>
                        </td>						 
						<td colspan=5 width="5%" style="border:0" align="left" > <gw:icon id="btnCopy" img="in" text="Copy" onclick="OnCopy()" styles="width:100%" /></td>
                        <td colspan=5 width="5%" style="border:0" align="left" >&nbsp;</td>
                       
                    </tr>
                    <tr tyle="height: 5%">
                        <td colspan=40 width="5%" style="border:0" align="left" >&nbsp;</td>
                        <td colspan=5 style="border:0" align="right">
                            <gw:icon id="btnSearch" img="in" text="Search" onclick="OnSearch()" />
                        </td>
					   
                        <td colspan=5 style="border:0" align="right" >
                            <gw:icon id="btnNew" img="in" alt="New" text="New" onclick="OnNew()" />
                        </td>
                        <td  colspan = 5 width="3%" style="border:0" align="right">
                            <gw:icon id="btnSave" img="in" alt="Save" text="Save" onclick="OnSave()" />
                        </td>
                        <td  colspan = 5 width="3%" style="border:0" align="right">
                            <gw:icon id="btnDelete" img="in" alt="Delete" text="Delete" onclick="OnDelete()" />
                        </td>
                        <td colspan=40 width="5%" style="border:0" align="left" >&nbsp;</td>
                    </tr>
                    <tr style="height: 87%">
                        <td colspan="100">
                            <gw:grid id='grdFactorEntry' 
                                header='SEQ|_PK|_THR_EVAGROUP_PK|ELEMENT_TYPE|ELEMENT_NM|WEIGHT|ELEMENT_LNM|ELEMENT_FNM|FACTOR_NM|FACTOR_LNM|FACTOR_FNM|TYPE|USE_YN|_THR_EVA_MASTER_PK'
                                format='0|0|0|0|0|0|0|0|0|0|0|0|3|0' 
                                aligns='0|0|0|0|0|3|0|0|0|0|0|0|0|0' 
                                defaults='||||||||||||-1|'
                                editcol='1|1|1|1|1|1|1|1|1|1|1|1|1|1' 
                                widths='400|0|0|1200|2000|800|2000|1950|2450|2450|2450|1200|1000|1000'
                                oncelldblclick="OnGridCellClick(this)"
                                sorting='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td colspan=100>
                            <table  style="width: 100%; height: 100%">
                                <tr style="height: 100%">
                                    <td colspan = 10 width="10%" style="border:0" align="right">
                                    </td>
                                    <td colspan =10 width="10%" style="border:0" align="right">
                                        Sum</td>
                                    <td colspan = 10 width="10%" style="background-color:Gray" align="left">
                                        <gw:textbox id="txtSum" />
                                    </td>
                                    <td colspan = 5 width="5%" style="border:0" align="right"></td>
                                    <td colspan = 20 width="20%" style="border:0" align="left"><gw:label img="new" id="lblMBO" /></td>
                                    <td colspan = 2 width="2%" style="border:0" align="left">&nbsp;</td>
                                    <td colspan = 20 width="20%" style="border:0" align="left"><gw:label img="new" id="lblCapa" /></td>
                                    <td colspan = 20 width="20%" style="border:0" align="left"><gw:label img="new" id="lblHr" /></td>
                                    <td colspan = 3 width="3%" style="border:0" align="right"></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<gw:textbox id="txtResult" styles="display:none"/> 
<gw:textbox id="txtResult_2" styles="display:none"/> 
</html>