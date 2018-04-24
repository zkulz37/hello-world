<!-- #include file="../../../system/lib/form.inc"  -->
<%   ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Evaluation Factor Entry</title>
</head>

<script>

var v_level ='';
function BodyInit()
{   
        var data="";
        data ="#A;Achivement|#C;Competence"; 
        grdFactorEntry.SetComboFormat(3,data);
        
        data = "<%=ESysLib.SetListDataSQL("SELECT pk , group_nm from thr_eva_group where del_if=0 and use_yn='Y'" )%>";    
        lstGroup.SetDataText(data);
        OnSearch();
}
function OnSearch()
{
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
    grdFactorEntry.SetGridText(grdFactorEntry.rows-1,2,  lstGroup.GetData());
}
function OnSave()
{
    if(CheckDataIsValid())
    {   
        dsoFactorEntry.Call();  
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
             if(grdFactorEntry.GetGridData(i,5) == "")
             {
                alert("Please input weight number at row"+i);
                return false;
             }
             else if(grdFactorEntry.GetGridData(i,8) == "")
             {
                alert("Please input factor name  at row"+i);
                return false;
             }
          }
          return true;
}
function sum()
 {
    var dValueSum=0, sumA=0;
      
    for(i=1; i<grdFactorEntry.rows; i++ ){
       dValueSum = Number(dValueSum) + Number(grdFactorEntry.GetGridData(i,5));
       if (grdFactorEntry.GetGridData(i,3) == "A")
       {        
            sumA += Number(grdFactorEntry.GetGridData(i,5));
       }
    }
    txtSum.text = ''+ dValueSum;
    if(dValueSum > 0){
        sumA = System.Round((sumA/dValueSum)*100,1);
        sumP = System.Round(100 - sumA,1);
        lblAchivement.text=sumA + ' %';
        lblCompetence.text=sumP + ' %';
    }
    else{
        lblAchivement.text=""
        lblCompetence.text="";
    }
    
}
function CheckSumwieght()
{
  var dValueSum=0;      
    for(i=1; i<grdFactorEntry.rows; i++ )
        dValueSum = Number(dValueSum) + Number(grdFactorEntry.GetGridData(i,5));
        if(dValueSum != 100)
        {
            alert("sum weight must = 100");
        }
}
function OnDataReceive(obj){
  if(obj.id == "dsoFactorEntry"){
    sum();
    if(grdFactorEntry.rows > 1){
        CheckSumwieght();
    }
  }
}
function GetOpinionContent(col)
{
    if(col == 8){
        return grdFactorEntry.GetGridData(grdFactorEntry.row, 8);
    }
    else if(col == 9){
        return grdFactorEntry.GetGridData(grdFactorEntry.row, 9);
    }
    else if(col == 10){
        return grdFactorEntry.GetGridData(grdFactorEntry.row, 10);
    }
}
function OnGridCellClick(obj)
{
     var content;
    var url=System.RootURL + "/form/ch/em/chem00020_1.aspx?col="+ event.col;   
    switch(event.col)
    {
        case 8:
                var winObj = System.OpenModal(url,700,550,"resizable:yes;status:yes", window);
                if ( winObj ){
                    grdFactorEntry.SetGridText(grdFactorEntry.row, 8,winObj);
                    
                }
        break;   
       case 9:
                var winObj = System.OpenModal(url,700,550,"resizable:yes;status:yes", window);
                
                if ( winObj ){
                    grdFactorEntry.SetGridText(grdFactorEntry.row, 9,winObj);
                }
        break;      
        case 10:
                var winObj = System.OpenModal(url,700,550,"resizable:yes;status:yes", window);
                
                if ( winObj ){
                    grdFactorEntry.SetGridText(grdFactorEntry.row,10,winObj);
                 }
             break;   
    }
    
}
</script>

<body bgcolor='#F5F8FF'>
    <!----------------------------------->
    <gw:data id="dsoFactorEntry" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11" function="HR_sel_chem00020" procedure="HR_upd_chem00020">  
                <input bind="grdFactorEntry"   >  
                    <input bind="lstGroup" />  	 															
                </input> 
                <output bind="grdFactorEntry" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table style="width: 100%; height: 100%">
        <tr>
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td width="20%">
                            Evaluation Group
                        </td>
                        <td width="20%">
                            <gw:list id="lstGroup" onchange="OnSearch()" />
                        </td>
                        <td width="51%">
                        </td>
                        <td style="width: 3%">
                            <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnNew()" />
                        </td>
                        <td style="width: 3%">
                            <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave()" />
                        </td>
                        <td style="width: 3%">
                            <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete()" />
                        </td>
                    </tr>
                    <tr style="height: 94%">
                        <td colspan="6">
                            <gw:grid id='grdFactorEntry' header='SEQ|_PK|_THR_EVAGROUP_PK|ELEMENT_TYPE|ELEMENT_NM|WEIGHT|ELEMENT_LNM|ELEMENT_FNM|FACTOR_NM|FACTOR_LNM|FACTOR_FNM|USE_YN'
                                format='0|0|0|0|0|0|0|0|0|0|0|3' aligns='0|0|0|0|0|3|0|0|0|0|0|0' defaults='|||||||||||-1'
                                editcol='1|1|1|1|1|1|1|1|1|1|1|1' widths='400|0|0|1200|2000|800|2000|1950|2450|2450|2450|500'
                                oncelldblclick="OnGridCellClick(this)"
                                sorting='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                    <tr style="height: 4%">
                        <td colspan="6">
                            <table  style="width: 100%; height: 100%">
                                <tr style="height: 100%">
                                    <td width="26%">
                                    </td>
                                    <td width="5%">
                                        Sum</td>
                                    <td width="10%" style="background-color:Gray">
                                        <gw:textbox id="txtSum" />
                                    </td>
                                    <td width="2%"></td>
                                    <td width="8%">Achivement:</td>
                                    <td width="7%"><gw:label img="new" id="lblAchivement" /></td>
                                    <td width="2%"> + </td>
                                    <td width="8%">Competence:</td>
                                    <td width="7%"><gw:label img="new" id="lblCompetence" /></td>
                                    <td width="25%"></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
