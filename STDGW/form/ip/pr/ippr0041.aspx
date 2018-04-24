<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Monitering Display</title>
    <style>
    .t-plan_nm{
        background-color:#3B6EA5; color: #EE0D00 ; font-size: 18
    }
    .t-real-plan_nm{
        background-color:#3B6EA5; color: white ; font-size: 18
    }  
    .t-actual_nm{
        background-color:#3B6EA5; color: #12CD1F ; font-size: 18
    }    
    .t-defect_nm{
        background-color:#3B6EA5; color: #ff3efd ; font-size: 18
    } 
    .t-rate_nm{
        background-color:#3B6EA5; color: #fff838 ; font-size: 18
    }    
    .t-plan{
        background-color:black; color: #EE0D00 ; font-size: 18
    }
    .t-real-plan{
        background-color:black; color: white ; font-size: 18
    }  
    .t-actual{
        background-color:black; color: #12CD1F ; font-size: 18
    }    
    .t-defect{
        background-color:black; color: #ff3efd ; font-size: 18
    } 
    .t-rate{
        background-color:black; color: #fff838 ; font-size: 18
    }                    
    .t-header{
        background-color:#C5D6FC; color: #660033 ; font-size: 21
    }
    .t-line{
        height:1%;font-size:15;background-color: #999966
    }   
    </style>
</head>
<%  ESysLib.SetUser("stm")%>

<script> 

var gID;
var gBlnFlag = true;

var offset=1;
var rowsNext = 20;
var rowsDisplay = 20;

var G1_LINE   = 0,   
    G1_plan_qty     = 1,   
    G1_r_p_qty      = 2,   
    G1_finish_Qty   = 3,  
    G1_defect_qty   = 4,   
    G1_Ratio        = 5;         

//------------------------------------------------------------------------------ 
    
function BodyInit()
{   
    BindingDataList();
    data_ippr0041.Call('SELECT'); 
}
//------------------------------------------------------------------------------ 

function BodyClose()
{
    
    window.clearInterval(timer);
    
}
//------------------------------------------------------------------------------
function SetStatusTable()
{
    var totalRows = grdGrade.rows -1;
    var previous  = document.all("idprevious");
    var next      = document.all("idnext"); 
    var tbname;
    var tbid ;
    
    // grdGrade.rows <=6 ->> an nut previous, next
    if (totalRows <= rowsDisplay)
    {
        previous.style.display ="none";
        next.style.display     ="none";
    }
    else
    {    
        // Set an nut previous hay an nut next
        if(offset==1)
            previous.style.display="none";
        else
            previous.style.display="";
            
        if(Number(totalRows)-Number(offset)>=rowsDisplay)    
            next.style.display="";
        else
            next.style.display="none";
    }
    
    // Set an table idtb1LINE
    for(i=1; i<=rowsDisplay; i++)
    {
        tbname = "idtb" + i ;
        tbid = document.all(tbname);
        tbid.style.display="";
    }

    // Number(totalRows) - Number(offset) + 1 = số cột dc hiển thị
    // + 1 để bắt đầu ẩn cột ko có dữ liệu
    for( i = Number(totalRows) - Number(offset) + 2; i <= rowsDisplay; i++)
    {
        tbname = "idtb" + i ;
        tbid = document.all(tbname);
        tbid.style.display="none";
    }
}

//------------------------------------------------------------------------------ 
var timer ;

function OnDataReceive(obj)
{
    switch (obj.id)
    {          
        case 'data_ippr0041':           
                
            offset=1;
            BindingDataTable();
            SetStatusTable();
            
            //--------- SET TIME --------------
            window.clearInterval(timer) ;

            timer = self.setInterval("data_ippr0041.Call('SELECT')",100000);                
            //---------------------------------
            
        break;             
    }
}
//------------------------------------------------------------------------------ 
function BindingDataList()
{
    var data = "<%=ESysLib.SetListDataSQL("select pk, factory_nm from tst_factory where del_if = 0 order by factory_nm")%>";  //country
    cboFactory.SetDataText(data + "|ALL|Select All"); 
    cboFactory.value= "7";
}
//------------------------------------------------------------------------------ 
function BindingDataTable()
{
    var totalRows = grdGrade.rows -1;

    var lastViewRow = Number(offset) + (Number(rowsDisplay)-1) <= totalRows ? Number(offset) + (Number(rowsDisplay)-1) : totalRows;
    
    var idLINE, idreq_qty, idfinish_qty, iddefect_qty, idrate, idrp_qty;
    
    var id_t_LINE, id_t_req_qty, id_t_finish_qty, id_t_defect_qty, id_t_rate, id_t_rp_qty;
    
    var k = 1; // impotant 
    
    for ( i=offset; i<=lastViewRow; i++)
    {           
        idLINE              = "GN_" + (k) ;
        id_t_LINE           = document.all(idLINE);
        //id_t_LINE.innerText = " " + grdGrade.GetGridData(i,G1_LINE);
        id_t_LINE.text      = " " + grdGrade.GetGridData(i,G1_LINE);
        
        idreq_qty                 = "RE_" + (k) ;
        id_t_req_qty              = document.all(idreq_qty);
        id_t_req_qty.innerText    = " " +  grdGrade.GetGridData(i,G1_plan_qty) ;
        
        idrp_qty                  = "RP_" + (k) ;
        id_t_rp_qty               = document.all(idrp_qty);
        id_t_rp_qty.innerText     = " " + grdGrade.GetGridData(i,G1_r_p_qty   );
        
        idfinish_qty              = "FN_" + (k);
        id_t_finish_qty           = document.all(idfinish_qty);
        id_t_finish_qty.innerText = " " + grdGrade.GetGridData(i,G1_finish_Qty) ;
        
        iddefect_qty              = "DF_" + (k);
        id_t_defect_qty           = document.all(iddefect_qty);
        id_t_defect_qty.innerText = " " + grdGrade.GetGridData(i,G1_defect_qty ) ;
        
        idrate                    = "RA_" + (k);
        id_t_rate                 = document.all(idrate);
        id_t_rate.innerText       = " " + grdGrade.GetGridData(i,G1_Ratio ) ;
        
        k = k + 1;
    }
    ShowChart();
}
//------------------------------------------------------------------------------
function onBackNextClick(index)
{
    switch(Number(index))
    {
        case -1:
            if ( offset > rowsNext )
                offset = Number(offset) - rowsNext;
        break;
        
        case 1:
            if ( offset < grdGrade.rows - rowsNext )
                offset = Number(offset) + rowsNext;
        break;
    }
    BindingDataTable();
    SetStatusTable();
}
//----------------------------------------------------------------------------

function ShowChart()        
{   
    this.Height        
    window.frames["ifrContent"].document.location.href = "ippr0042.aspx?offset=" + offset + "&rowsDisplay=" + rowsDisplay + "&factory_pk=" + cboFactory.value+"&p_date="+dtDate.GetData();          
}
//------------------------------------------------------------------------------
function ShowLineDetail(line_id)
{
            var fpath = System.RootURL + "/form/ip/pr/ippr0043.aspx?line_id="+line_id+"&p_date="+dtDate.GetData();
            System.OpenModal( fpath , 900 , 500, 'resizable:yes;status:yes');
}
//------------------------------------------------------------------------------
function LoadingPO()
{
    var fpath = System.RootURL + "/form/ip/pr/ippr0044.aspx"; 
    System.OpenModeless( fpath , 2000 ,  2000, 'resizable:yes;status:no;fullscreen:yes;titlebar:yes;location:yes');    
    window.close();
}
//------------------------------------------------------------------------------
function OnChangeDate(){
    data_ippr0041.Call('SELECT');
}
</script>

<body onunload="window.clearInterval(timer);">
    <!------------------------------------------------------------------------------>
    <gw:data id="data_ippr0041" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,3,9" function="stm.sp_sel_ippr0041" > 
                <input bind="grdGrade">  
                    <input bind="cboFactory" /> 
                    <input bind="dtDate" />     
                </input> 
                <output bind="grdGrade" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!----------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%; background-color: Black" border="1">
        <tr style="height: 1%">
            <td colspan="11">
                <table style="width: 100%; height: 100%">
                    <tr>
                    <td style="width: 5%; color: #ffffff" nowrap>
                            Date</td>
                        <td><gw:datebox id="dtDate" lang="1" onchange="OnChangeDate()"/></td>    
                        <td style="width: 5%; color: #ffffff" nowrap>
                            Factory</td>
                        <td style="width: 20%">
                            <gw:list id="cboFactory" styles='width:100%;color: blue' onchange="data_ippr0041.Call('SELECT');" />
                        </td>
                        <td style="width: 90%; font-size: 20; color: #FF0000" align="center">
                            MONITORING
                        </td>
                        <td id="idprevious" style="width: 5%" nowrap>
                            <a title="Click here to previous infomation" onclick="onBackNextClick(-1)" href="#tips" style="text-decoration: none;
                                color=#ffffff"><b>Previous</b></a></td>
                        <td style="width: 5%">
                        </td>
                        <td id="idnext" style="width: 5%">
                            <a title="Click here to next infomation" onclick="onBackNextClick(1)" href="#tips" style="text-decoration: none;
                                color=#ffffff"><b>Next</b></a></td>
                        <td style="width: 10%" valign="middle" align="right">
                            <gw:icon id="idBtn1" img="in" text="OPEN PO" styles='width:100%' onclick="LoadingPO()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 1%">
            <td style="width: 10%">
                <table width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td align="center" class="t-header">
                            LINE
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100%" class="t-plan_nm">
                            PLAN
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td class="t-real-plan_nm" nowrap>
                            REAL PLAN</td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td class="t-actual_nm">
                            ACTUAL</td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td class="t-defect_nm">
                            DEFECT</td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td class="t-rate_nm">
                            RATE(%)</td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 9%">
                <table id="idtb1" width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td align="center" class="t-header">
                                <gw:label id="GN_1" text="LINE" title="Click here to see line detail status" styles='cursor:pointer;width:100%;color=#660033 ; font-size: 21' csstype="mandatory" onclick="ShowLineDetail(this.text);" />
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100%" align="right" id="RE_1" class="t-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RP_1" class="t-real-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="FN_1" class="t-actual">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="DF_1" class="t-defect">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RA_1" class="t-rate">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 9%">
                <table id="idtb2" width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td align="center" class="t-header">
                                <gw:label id="GN_2" text="LINE" title="Click here to see line detail status" styles='cursor:pointer;width:100%;color=#660033 ; font-size: 21' csstype="mandatory" onclick="ShowLineDetail(this.text);"/>
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100%" align="right" id="RE_2" class="t-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RP_2" class="t-real-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="FN_2" class="t-actual">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="DF_2" class="t-defect">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RA_2" class="t-rate">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 9%">
                <table id="idtb3" width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td align="center" class="t-header">
                                <gw:label id="GN_3" text="LINE" title="Click here to see line detail status" styles='cursor:pointer;width:100%;color=#660033 ; font-size: 21' csstype="mandatory" onclick="ShowLineDetail(this.text);"/>
                            </a>
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100%" align="right" id="RE_3" class="t-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RP_3" class="t-real-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="FN_3" class="t-actual">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="DF_3" class="t-defect">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RA_3" class="t-rate">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 9%">
                <table id="idtb4" width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td align="center" class="t-header">
                                <gw:label id="GN_4" text="LINE" title="Click here to see line detail status" styles='cursor:pointer;width:100%;color=#660033 ; font-size: 21' csstype="mandatory" onclick="ShowLineDetail(this.text);"/>
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100%" align="right" id="RE_4" class="t-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RP_4" class="t-real-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="FN_4" class="t-actual">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="DF_4" class="t-defect">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RA_4" class="t-rate">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 9%">
                <table id="idtb5" width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td align="center" class="t-header">
                                <gw:label id="GN_5" text="LINE" title="Click here to see line detail status" styles='cursor:pointer;width:100%;color=#660033 ; font-size: 21' csstype="mandatory" onclick="ShowLineDetail(this.text);"/>
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100%" id="RE_5" align="right" class="t-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RP_5" class="t-real-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="FN_5" class="t-actual">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="DF_5" class="t-defect">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RA_5" class="t-rate">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 9%">
                <table id="idtb6" width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td align="center" class="t-header">
                                <gw:label id="GN_6" text="LINE" title="Click here to see line detail status" styles='cursor:pointer;width:100%;color=#660033 ; font-size: 21' csstype="mandatory" onclick="ShowLineDetail(this.text);"/>
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100%" id="RE_6" align="right" class="t-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RP_6" class="t-real-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="FN_6" class="t-actual">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="DF_6" class="t-defect">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RA_6" class="t-rate">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 9%">
                <table id="idtb7" width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td align="center" class="t-header">
                                <gw:label id="GN_7" text="LINE" title="Click here to see line detail status" styles='cursor:pointer;width:100%;color=#660033 ; font-size: 21' csstype="mandatory" onclick="ShowLineDetail(this.text);"/>
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100%" id="RE_7" align="right" class="t-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RP_7" class="t-real-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="FN_7" class="t-actual">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="DF_7" class="t-defect">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RA_7" class="t-rate">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 9%">
                <table id="idtb8" width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td align="center" class="t-header">
                                <gw:label id="GN_8" text="LINE" title="Click here to see line detail status" styles='cursor:pointer;width:100%;color=#660033 ; font-size: 21' csstype="mandatory" onclick="ShowLineDetail(this.text);"/>
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100%" id="RE_8" align="right" class="t-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RP_8" class="t-real-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="FN_8" class="t-actual">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="DF_8" class="t-defect">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RA_8" class="t-rate">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 9%">
                <table id="idtb9" width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td align="center" class="t-header">
                                <gw:label id="GN_9" text="LINE" title="Click here to see line detail status" styles='cursor:pointer;width:100%;color=#660033 ; font-size: 21' csstype="mandatory" onclick="ShowLineDetail(this.text);"/>
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100%" id="RE_9" align="right" class="t-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RP_9" class="t-real-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="FN_9" class="t-actual">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="DF_9" class="t-defect">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RA_9" class="t-rate">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 9%">
                <table id="idtb10" width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td align="center" class="t-header">
                                <gw:label id="GN_10" text="LINE" title="Click here to see line detail status" styles='cursor:pointer;width:100%;color=#660033 ; font-size: 21' csstype="mandatory" onclick="ShowLineDetail(this.text);"/>
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100%" id="RE_10" align="right" class="t-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RP_10" class="t-real-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="FN_10" class="t-actual">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="DF_10" class="t-defect">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RA_10" class="t-rate">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="11">
                &nbsp;</td>
        </tr>
        <tr style="height: 1%">
            <td style="width: 9%">
                <table width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td align="center" class="t-header">
                            LINE
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100%" class="t-plan_nm">
                            PLAN
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td class="t-real-plan_nm" nowrap>
                            REAL PLAN</td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td class="t-actual_nm">
                            ACTUAL</td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td class="t-defect_nm">
                            DEFECT</td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td class="t-rate_nm">
                            RATE(%)</td>
                    </tr>
                    <tr class="t-line">
                    </tr>
                </table>
            </td>
            <td style="width: 9%">
                <table id="idtb11" width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td align="center" class="t-header">
                                <gw:label id="GN_11" text="LINE" title="Click here to see line detail status" styles='cursor:pointer;width:100%;color=#660033 ; font-size: 21' csstype="mandatory" onclick="ShowLineDetail(this.text);"/>
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100%" align="right" id="RE_11" class="t-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RP_11" class="t-real-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="FN_11" class="t-actual">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="DF_11" class="t-defect">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RA_11" class="t-rate">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 9%">
                <table id="idtb12" width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td align="center" class="t-header">
                                <gw:label id="GN_12" text="LINE" title="Click here to see line detail status" styles='cursor:pointer;width:100%;color=#660033 ; font-size: 21' csstype="mandatory" onclick="ShowLineDetail(this.text);"/>
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100%" id="RE_12" align="right" class="t-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RP_12" class="t-real-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="FN_12" class="t-actual">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="DF_12" class="t-defect">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RA_12" class="t-rate">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 9%">
                <table id="idtb13" width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td align="center" class="t-header">
                                <gw:label id="GN_13" text="LINE" title="Click here to see line detail status" styles='cursor:pointer;width:100%;color=#660033 ; font-size: 21' csstype="mandatory" onclick="ShowLineDetail(this.text);"/>
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100%" id="RE_13" align="right" class="t-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RP_13" class="t-real-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="FN_13" class="t-actual">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="DF_13" class="t-defect">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RA_13" class="t-rate">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 9%">
                <table id="idtb14" width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td align="center" class="t-header">
                                <gw:label id="GN_14" text="LINE" title="Click here to see line detail status" styles='cursor:pointer;width:100%;color=#660033 ; font-size: 21' csstype="mandatory" onclick="ShowLineDetail(this.text);"/>
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100%" id="RE_14" align="right" class="t-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RP_14" class="t-real-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="FN_14" class="t-actual">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="DF_14" class="t-defect">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RA_14" class="t-rate">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 9%">
                <table id="idtb15" width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td align="center" class="t-header">
                                <gw:label id="GN_15" text="LINE" title="Click here to see line detail status" styles='cursor:pointer;width:100%;color=#660033 ; font-size: 21' csstype="mandatory" onclick="ShowLineDetail(this.text);"/>
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 50%" id="RE_15" align="right" class="t-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RP_15" class="t-real-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="FN_15" class="t-actual">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="DF_15" class="t-defect">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RA_15" class="t-rate">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 9%">
                <table id="idtb16" width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td align="center" class="t-header">
                                <gw:label id="GN_16" text="LINE" title="Click here to see line detail status" styles='cursor:pointer;width:100%;color=#660033 ; font-size: 21' csstype="mandatory" onclick="ShowLineDetail(this.text);"/>
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100%" id="RE_16" align="right" class="t-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RP_16" class="t-real-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="FN_16" class="t-actual">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="DF_16" class="t-defect">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RA_16" class="t-rate">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 9%">
                <table id="idtb17" width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td align="center" class="t-header">
                                <gw:label id="GN_17" text="LINE" title="Click here to see line detail status" styles='cursor:pointer;width:100%;color=#660033 ; font-size: 21' csstype="mandatory" onclick="ShowLineDetail(this.text);"/>
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100%" id="RE_17" align="right" class="t-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RP_17" class="t-real-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="FN_17" class="t-actual">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="DF_17" class="t-defect">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RA_17" class="t-rate">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 9%">
                <table id="idtb18" width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td align="center" class="t-header">
                                <gw:label id="GN_18" text="LINE" title="Click here to see line detail status" styles='cursor:pointer;width:100%;color=#660033 ; font-size: 21' csstype="mandatory" onclick="ShowLineDetail(this.text);"/>
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100%" id="RE_18" align="right" class="t-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RP_18" class="t-real-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="FN_18" class="t-actual">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="DF_18" class="t-defect">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RA_18" class="t-rate">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 9%">
                <table id="idtb19" width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td align="center" class="t-header">
                                <gw:label id="GN_19" text="LINE" title="Click here to see line detail status" styles='cursor:pointer;width:100%;color=#660033 ; font-size: 21' csstype="mandatory" onclick="ShowLineDetail(this.text);"/>
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100%" id="RE_19" align="right" class="t-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RP_19" class="t-real-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="FN_19" class="t-actual">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="DF_19" class="t-defect">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RA_19" class="t-rate">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 9%">
                <table id="idtb20" width="100%" cellpadding="0" cellspacing="0" border="0" >
                    <tr>
                        <td align="center" class="t-header">
                                <gw:label id="GN_20" text="LINE" title="Click here to see line detail status" styles='cursor:pointer;width:100%;color=#660033 ; font-size: 21' csstype="mandatory" onclick="ShowLineDetail(this.text);"/>
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100%" id="RE_20" align="right" class="t-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RP_20" class="t-real-plan">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="FN_20" class="t-actual">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="DF_20" class="t-defect">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" id="RA_20" class="t-rate">
                        </td>
                    </tr>
                    <tr class="t-line">
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 100%">
            <td colspan="11" align="center" style="height: 100%">
                <iframe id="ifrContent" style="width: 100%; height: 100%; background-color: Black" frameborder="0"></iframe>
            </td>
        </tr>
    </table>
</body>
<!------------------------------------------------------->
<gw:grid id='grdGrade' header='LINE|plan_qty|r_p_qty|finish_qty|defect_qty|ratio' format='0|0|0|0|0|0'
    aligns='0|0|0|0|0|0' editcol='0|0|0|0|0|0' widths='1000|1000|1000|1000|1000|1000' sorting='T' styles='width:100%; height:460;display:none' />
<!------------------------------------------------------->
</html>
