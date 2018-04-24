<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>Packing WI Entry</title>
</head>

<script>
var p_action  = 'view';
var rtnLGCode = '' ;

var G1_SO_M_PK          = 0,
    G1_SO_D_PK          = 1,
    G1_PO_NO            = 2,
    G1_SPEC01_PK        = 3,
    G1_SPEC01_NM        = 4,
    G1_SPEC02_PK        = 5,
    G1_SPEC02_NM        = 6,
    G1_SPEC03_PK        = 7,
    G1_SPEC03_NM        = 8,
    G1_SPEC04_PK        = 9,
    G1_SPEC04_NM        = 10,
    G1_SPEC05_PK        = 11,
    G1_SPEC05_NM        = 12,
    G1_WI_QTY           = 13,
    G1_PACKED_QTY       = 14,
    G1_BAL_QTY          = 15,
    G1_REMARK           = 16,
    G1_PACK_WI_M_PK     = 17,
    G1_PACK_WI_D_PK     = 18;

var G2_AS_SL            = 0,
	G2_PackagesTypePK	= 1,
    G2_PACK_CODE        = 2,
    G2_PACK_NAME        = 3, 
    G2_Packages         = 4;

var G3_SPEC01_PK    = 0,
    G3_SPEC01_NM    = 1,
    G3_SPEC02_PK    = 2,
    G3_SPEC02_NM    = 3,
    G3_SPEC03_PK    = 4,
    G3_SPEC03_NM    = 5,
    G3_SPEC04_PK    = 6,
    G3_SPEC04_NM    = 7,
    G3_SPEC05_PK    = 8,
    G3_SPEC05_NM    = 9,
    G3_QTY          = 10;

var GH_PK               =0,
    GH_GRID_TYPE        =1,
    GH_COL01_HEADER     =2,
    GH_COL01_DISPLAY    =3,
    GH_COL02_HEADER     =4,
    GH_COL02_DISPLAY    =5,
    GH_COL03_HEADER     =6,
    GH_COL03_DISPLAY    =7,
    GH_COL04_HEADER     =8,
    GH_COL04_DISPLAY    =9,
    GH_COL05_HEADER     =10,
    GH_COL05_DISPLAY    =11,
    GH_DESCRIPTION      =12;
    
 var v_language = "<%=Session("SESSION_LANG")%>";
//=========================================================================
function OnToggle(pos)
{ 
    var left  = document.all("t-left");    
    var right = document.all("t-right");   
    var imgArrow1 = document.all("imgArrow1");   
    var imgArrow2 = document.all("imgArrow2"); 
    
    if ( pos == '1' ) 
    { 
        if ( imgArrow1.status == "expand" && imgArrow2.status == "expand" )
        {
            left.style.display  ="none";
            right.style.display ="";      
            
            right.style.width  ="99%";
            
            imgArrow1.status = "collapse";
            imgArrow2.status = "expand";
            
            imgArrow1.style.display="none";
            imgArrow2.style.display="";                         
        }
        else if ( imgArrow1.status == "expand" && imgArrow2.status == "collapse" )
        {
            left.style.display  ="";
            right.style.display ="";
            
            left.style.width   ="54%";
            right.style.width  ="44%";
            
            imgArrow1.status = "expand";
            imgArrow2.status = "expand";
            
            imgArrow1.style.display="";
            imgArrow2.style.display="";
        }
    }    
    else
    {
        if ( imgArrow1.status == "expand" && imgArrow2.status == "expand" )
        {
            left.style.width ="99%";
            
            right.style.display ="";       
            right.style.display ="none";
            
            imgArrow1.status = "expand";
            imgArrow2.status = "collapse";
            
            imgArrow1.style.display="";
            imgArrow2.style.display="none";                        
        }
        else if ( imgArrow1.status == "collapse" && imgArrow2.status == "expand" )
        {
            left.style.display  ="";
            right.style.display ="";
                    
            left.style.width   ="54%";
            right.style.width  ="44%";
            
            imgArrow1.status = "expand";
            imgArrow2.status = "expand";
            
            imgArrow1.style.display="";
            imgArrow2.style.display="";
        }
    }    
} 
 //==================================================================
 function BodyInit()
 {
    data_dsep00070_header.Call("SELECT");
    //-----------------------------------    
 } 
 //==================================================================
 function Pageload()
 {
    if (v_language!="ENG")
        System.Translate(document);
    //-----------------------------------
    
    txtChargerNm.SetEnable(false);
    txtWINo.SetEnable(false);
    txtPONo.SetEnable(false);
    //-----------------------------------
    FormatGrid();
    
    var income = ""
    income = "<%=Request.querystring("income_pk")%>";
    txtWIMasterPK.text = income;
    if(txtWIMasterPK.text !="")
    {
        OnSearch("data_dsep00070");
    }
 }
 //======================================================================
 function FormatGrid()
 {    
      var trl;   
      //-------------------------------------------------
      trl = grdWIDetail.GetGridControl();	
      trl.ColFormat(G1_WI_QTY)   = "###,###,###,###,###";
      trl.ColFormat(G1_PACKED_QTY) = "###,###,###,###,###";
      trl.ColFormat(G1_BAL_QTY)    = "###,###,###,###,###";
      //-------------------------------------------------
      trl = grdPackagesItem.GetGridControl();	
      trl.ColFormat(G3_QTY) = "###,###,###,###,###";   
      
      trl.MergeCells = 2;
      trl.MergeCol(G3_SPEC01_PK) = true;
      trl.MergeCol(G3_SPEC01_NM)   = true;
      trl.MergeCol(G3_SPEC02_PK) = true;  
      trl.MergeCol(G3_SPEC02_NM)   = true;
      trl.MergeCol(G3_SPEC03_PK) = true;
      trl.MergeCol(G3_SPEC03_NM)   = true;  
      trl.MergeCol(G3_SPEC04_PK) = true;
      trl.MergeCol(G3_SPEC04_NM)   = true;
      trl.MergeCol(G3_SPEC05_PK) = true;  
      trl.MergeCol(G3_SPEC05_NM)   = true;    
      
      var data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGSA3010') FROM DUAL" )%>";    
      lstAtt01.SetDataText(data);                      
 }  
 //======================================================================   

function OnPopUp(n)
{
    switch(n)
    {
        case 'SO':
            if ( data_dsep00070.GetStatus() == '20' || ( txtWIMasterPK.text != '' && grdWIDetail.rows == 1 ) )
            {
                var path = System.RootURL + "/form/ds/ep/dsep00071.aspx";
	            var object = System.OpenModal( path , 1000 , 650 ,  'resizable:yes;status:yes', this);
            	
	            if ( object != null )
	            { 	            
	                //-----------------                  
                    for ( var i=0; i< object.length; i++)
                    {
                        data = object[i];
                        
                        grdWIDetail.AddRow();

                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_SO_M_PK,  data[18] );
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_SO_D_PK, data[17] );
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_PO_NO,  data[0]  );

                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_SPEC01_NM,   data[1]  );                              
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_SPEC01_PK, data[11] );
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_SPEC01_NM,   data[1]  );
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_SPEC02_PK, data[12] );
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_SPEC02_NM,   data[2]  );
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_SPEC03_PK, data[13] );
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_SPEC03_NM,   data[3]  );
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_SPEC04_PK, data[14] );
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_SPEC04_NM,   data[4]  );
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_SPEC05_PK, data[15] );
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_SPEC05_NM,   data[5]  );
                        
                        if ( Number(data[9]) + Number(data[10]) > 0 )
                        {
                            grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_WI_QTY, Number(data[9]) + Number(data[10]) );
                        }
                        else
                        {
                            grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_WI_QTY, Number(data[6]) - Number(data[7]) );                    
                        }                      
                    } 
                    //-------------------                
                    grdWIDetail.Subtotal( 0, 2, -1, '13!14!15','###,###,###');
                }
            }
            else if ( txtWIMasterPK.text != '' )
            {
                 var path = System.RootURL + '/form/ds/ep/dsep00077.aspx?WI_PK=' + txtWIMasterPK.text ;
                 var obj = System.OpenModal( path , 300 , 150 ,  'resizable:yes;status:yes', this);            
            }
            else
            {
                alert('Pls Add New W/I or delete all items.');
            }    
        break;
        
        case 'WINo':
            var path = System.RootURL + "/form/ds/ep/dsep00072.aspx";
	        var object = System.OpenModal( path , 800 , 500 ,  'resizable:yes;status:yes');
	        
	        if ( object != null )
	        {   
	            txtWIMasterPK.SetDataText(object[0]);
	            
	            OnSearch('data_dsep00070');
	        }
        break;  
        
        case 'Charger' :
             var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
             var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
             if ( obj != null )
             {
                txtChargerPK.text = obj[0];
                txtChargerNm.text = obj[2];
             }
        break;  
        
        case 'PackingType' : 
             if ( grdWIDetail.rows > 1 && txtWIMasterPK.text != '' )
             { 
			 	 txtWIDetailPK.text = '' ;
				 
                 if ( chkAllItem.value == 'N' ) 
                 {      
                         //---------------------------
                         var array_wi_detail_pk = '' ;
                         var t_link = '' ;
                         
                         for ( var i=1; i<grdWIDetail.rows-1; i++)   
                         {
                             if ( grdWIDetail.GetGridControl().isSelected(i) == true )
                             {
                                array_wi_detail_pk = array_wi_detail_pk + t_link + grdWIDetail.GetGridData( i, G1_PACK_WI_D_PK);
                                t_link = ',' ; 
                             }
                         }
                                          
                         txtWIDetailPK.text = array_wi_detail_pk ;
                 }                               
                 //---------------------------
                 var path = System.RootURL + '/form/ds/ep/dsep00073.aspx?WI_PK=' + txtWIMasterPK.text + '||||';
                 var obj = System.OpenModal( path ,950 , 650 ,  'resizable:yes;status:yes', this);
                 
                 OnSearch('grdPackages');
             }
             else
             {
                alert('Pls save the W/I with S/O Item.');
             }
        break; 
        
        case 'Style':
             var path = System.RootURL + '/form/fp/ab/fpab00080.aspx?group_type=Y|Y||||';
             var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
             
             if ( obj != null )
             {
                txtStylePK.text   = obj[0];
                txtStyleName.text = obj[1] + ' - ' + obj[2];
             }	        
        break;   
        
        case 'MakePackages':
             if ( txtWIMasterPK.text != '' )
             {
                  var path = System.RootURL + '/form/ds/ep/dsep00074.aspx';
                  var obj = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes', this);
                          
                  OnSearch('grdPackages');            
             } 
             else
             {
                  alert('Pls select Pack WI.');
             }  
        break; 
        
        case 'Att01':
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGSA3010";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGSA3010';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstAtt01.value = object[1];        
	                }    
	         }                
        break;          
          	              
    }
}
//=========================================================================
function OnReportClick()
 {
     if (txtWIMasterPK.text != "" && grdPackages.GetGridData(grdPackages.row, G2_PackagesTypePK) != "")
        { 
              //var url =System.RootURL + '/reports/ds/cd/dscd00030.xls?sopk=' + txtMasterPK.text  ;
              //var url =System.RootURL + '/reports/ds/cd/dscd00030_YC.aspx?sopk=' + txtMasterPK.text  ;
              var url =System.RootURL + '/reports/ds/ep/rpt_dsep00071.aspx?p_pa_packing_wi_pk='+ txtWIMasterPK.text + '&p_pa_packages_type_pk=' + grdPackages.GetGridData(grdPackages.row, G2_PackagesTypePK) + '&p_po_no=' +  txtPONo.text + '&p_wi_date=' + dtWIDate.value;
	          window.open(url); 
        }       
    else    
              alert("Please,Select a Take out to print !")
   
 }
//=========================================================================
function OnSearch(pos)
{
    switch (pos)
    {
        case 'data_dsep00070' :                       
                data_dsep00070.Call("SELECT");            
        break;
        
        case 'Master' :
            if ( txtWIMasterPK.text == '' )
            {
               OnPopUp('WINo');
            }
            else
            {
                OnSearch('data_dsep00070');
            }           
        break;
        
        case 'grdWIDetail' :
            data_dsep00070_1.Call("SELECT");
        break;
        
        case 'grdPackages':
            if ( txtWIMasterPK.text == '' )
            {
                alert('Pls select Pack WI.');
            }
            else
            {
                data_dsep00070_2.Call("SELECT");
            }    
        break;
        
        case 'grdPackagesItem':
            if ( grdPackages.row > 0 )
            {
                txtASSL.text           = grdPackages.GetGridData( grdPackages.row, G2_AS_SL          );
                txtPackagesTypePK.text = grdPackages.GetGridData( grdPackages.row, G2_PackagesTypePK );
            }
            else
            {
                txtASSL.text           = '';
                txtPackagesTypePK.text = '' ;
            }
            
            data_dsep00070_3.Call("SELECT");  
        break;        
    }
}
//=========================================================================
function OnAddNew(index)
{
    switch(index)
    {
        case 'WI_MASTER':
            data_dsep00070.StatusInsert();
            
            txtWINo.text = '*** New WI ***' ;
            grdWIDetail.ClearData();
            
            txtChargerNm.text = "<%=Session("USER_NAME")%>";
            txtChargerPK.text = "<%=Session("EMPLOYEE_PK")%>";             
        break;    
				 
		case 'FreeItem':
				var path = System.RootURL + "/form/fp/ab/fpab00670.aspx?group_type=Y|Y|Y|Y|Y|Y";
	            var object = System.OpenModal( path , 1000 , 650 ,  'resizable:yes;status:yes', this);
            	
	            if ( object != null )
	            { 	            
	                //-----------------  
					 
                    for ( var i=0; i< object.length; i++)
                    {
                        data = object[i];
                        
                        grdWIDetail.AddRow();

                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_PACK_WI_M_PK, txtWIMasterPK.text );
						
						grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_PO_NO, grdWIDetail.rows-1 );
                                                 
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_SPEC01_PK, data[3] );						
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_SPEC01_NM, data[4] );
					
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_SPEC02_PK, data[5] );						
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_SPEC02_NM, data[6] );
						
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_SPEC03_PK, data[7] );						
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_SPEC03_NM, data[8] );
						
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_SPEC04_PK, data[9] );						
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_SPEC04_NM, data[10]);
						
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_SPEC05_PK, data[11]);
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_SPEC05_NM, data[12]);						        
                    } 
                    //-------------------                
                }					
		break; 
    }
}
//=========================================================================
function OnSave(index)
{
    switch(index)
    {
        case 'data_dsep00070':
                
            p_action = 'update';
            data_dsep00070.Call();
            
        break;
        
        case 'grdWIDetail':
            for ( var i=1; i<grdWIDetail.rows-1 ; i++ )
            {
                if ( grdWIDetail.GetGridData( i, G1_PACK_WI_M_PK ) == '' )
                {
                    grdWIDetail.SetGridText ( i, G1_PACK_WI_M_PK , txtWIMasterPK.text );
                }
            }   
                     
            data_dsep00070_1.Call();
        break;
    }
}

//=========================================================================
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'data_dsep00070':
            //---------------------------       
            if ( p_action == 'update' )
            {                
                OnSave('grdWIDetail');
            }    
            else    
            {
                OnSearch('grdWIDetail');
            }    
        break;
                  
        case 'data_dsep00070_1' :
        
            p_action = '' ;
            
            if ( grdWIDetail.rows > 1 )
            {
                grdWIDetail.SetCellBold( 1, G1_WI_QTY,   grdWIDetail.rows - 1, G1_WI_QTY,   true);
                grdWIDetail.SetCellBold( 1, G1_PACKED_QTY, grdWIDetail.rows - 1, G1_PACKED_QTY, true);
                grdWIDetail.SetCellBold( 1, G1_BAL_QTY,    grdWIDetail.rows - 1, G1_BAL_QTY,    true);
                
                grdWIDetail.SetCellBgColor( 1, G1_WI_QTY , grdWIDetail.rows - 1, G1_BAL_QTY , 0xCCFFFF ); 
                
                grdWIDetail.Subtotal( 0, 2, -1, '13!14!15','###,###,###');   
            }

        break;
        
        case 'data_dsep00070_2' :
            
            if ( grdPackages.rows > 1 )
            {
                grdPackages.SetCellBold( 1, G2_Packages, grdPackages.rows - 1, G2_Packages, true);
            }
            
            OnSearch('grdPackagesItem');
        break;   
        
        case 'data_dsep00070_3' :
            
            if ( grdPackagesItem.rows > 1 )
            {
                grdPackagesItem.SetCellBold( 1, G3_QTY, grdPackagesItem.rows - 1, G3_QTY, true);
                
                grdPackagesItem.Subtotal( 0, 2, -1, '10','###,###,###');
            }
        break;
        
        case 'data_fpab00220_2':
            if ( txtLGGroupCodeID.text == 'LGSA3010')
            {
                lstAtt01.SetDataText(txtLGCodeList.text);  
                lstAtt01.value = rtnLGCode;                      
            }        
        break;  
        case'data_dsep00070_header':
            if(grdHeader.rows > 1)
            {
                if(grdHeader.GetGridData(1,GH_COL01_DISPLAY)==0)
                {
                    grdPackagesItem.GetGridControl().ColHidden(G3_SPEC01_NM) = true ;
                    grdWIDetail.GetGridControl().ColHidden(G1_SPEC01_NM) = true ;
                }
                else
                {
                    grdPackagesItem.GetGridControl().ColHidden(G3_SPEC01_NM) = false ;
                    grdWIDetail.GetGridControl().ColHidden(G1_SPEC01_NM) = false ;
                    grdPackagesItem.GetGridControl().Cell(0, 0, G3_SPEC01_NM, 0,G3_SPEC01_NM) = grdHeader.GetGridData(1,GH_COL01_HEADER);
                    grdWIDetail.GetGridControl().Cell(0, 0, G1_SPEC01_NM, 0,G1_SPEC01_NM) = grdHeader.GetGridData(1,GH_COL01_HEADER);
                }
                if(grdHeader.GetGridData(1,GH_COL02_DISPLAY)==0)
                {
                    grdPackagesItem.GetGridControl().ColHidden(G3_SPEC02_NM) = true ;
                    grdWIDetail.GetGridControl().ColHidden(G1_SPEC02_NM) = true ;
                }
                else
                {
                    grdPackagesItem.GetGridControl().ColHidden(G3_SPEC02_NM) = false ;
                    grdWIDetail.GetGridControl().ColHidden(G1_SPEC02_NM) = false ;
                    grdPackagesItem.GetGridControl().Cell(0, 0, G3_SPEC02_NM, 0,G3_SPEC02_NM) = grdHeader.GetGridData(1,GH_COL02_HEADER);
                    grdWIDetail.GetGridControl().Cell(0, 0, G1_SPEC02_NM, 0,G1_SPEC02_NM) = grdHeader.GetGridData(1,GH_COL02_HEADER);
                }
                if(grdHeader.GetGridData(1,GH_COL03_DISPLAY)==0)
                {
                    grdPackagesItem.GetGridControl().ColHidden(G3_SPEC03_NM) = true ;
                    grdWIDetail.GetGridControl().ColHidden(G1_SPEC03_NM) = true ;
                }
                else
                {
                    grdPackagesItem.GetGridControl().ColHidden(G3_SPEC03_NM) = false ;
                    grdWIDetail.GetGridControl().ColHidden(G1_SPEC03_NM) = false ;
                    grdPackagesItem.GetGridControl().Cell(0, 0, G3_SPEC03_NM, 0,G3_SPEC03_NM) = grdHeader.GetGridData(1,GH_COL03_HEADER);
                    grdWIDetail.GetGridControl().Cell(0, 0, G1_SPEC03_NM, 0,G1_SPEC03_NM) = grdHeader.GetGridData(1,GH_COL03_HEADER);
                }
                if(grdHeader.GetGridData(1,GH_COL04_DISPLAY)==0)
                {
                    grdPackagesItem.GetGridControl().ColHidden(G3_SPEC04_NM) = true ;
                    grdWIDetail.GetGridControl().ColHidden(G1_SPEC04_NM) = true ;
                }
                else
                {
                    grdPackagesItem.GetGridControl().ColHidden(G3_SPEC04_NM) = false ;
                    grdWIDetail.GetGridControl().ColHidden(G1_SPEC04_NM) = false ;
                    grdPackagesItem.GetGridControl().Cell(0, 0, G3_SPEC04_NM, 0,G3_SPEC04_NM) = grdHeader.GetGridData(1,GH_COL04_HEADER);
                    grdWIDetail.GetGridControl().Cell(0, 0, G1_SPEC04_NM, 0,G1_SPEC04_NM) = grdHeader.GetGridData(1,GH_COL04_HEADER);
                }
                if(grdHeader.GetGridData(1,GH_COL05_DISPLAY)==0)
                {
                    grdPackagesItem.GetGridControl().ColHidden(G3_SPEC05_NM) = true ;
                    grdWIDetail.GetGridControl().ColHidden(G1_SPEC05_NM) = true ;
                }
                else
                {
                    grdPackagesItem.GetGridControl().ColHidden(G3_SPEC05_NM) = false ;
                    grdWIDetail.GetGridControl().ColHidden(G1_SPEC05_NM) = false ;
                    grdPackagesItem.GetGridControl().Cell(0, 0, G3_SPEC05_NM, 0,G3_SPEC05_NM) = grdHeader.GetGridData(1,GH_COL05_HEADER);
                    grdWIDetail.GetGridControl().Cell(0, 0, G1_SPEC05_NM, 0,G1_SPEC05_NM) = grdHeader.GetGridData(1,GH_COL05_HEADER);
                }
            }
            
            Pageload();
        break;                        
    }
}

//=========================================================================
function OnDelete(pos)
{
    switch(pos)
    {
        case 'WI_MASTER' :
            if ( grdWIDetail.rows > 1 )
            {
                alert('Pls delete details first.');
            }
            else
            {
                if ( confirm('Would you like to delete this W/I ?') )
                {
                    data_dsep00070.StatusDelete();
                    data_dsep00070.Call();
                }    
            }    
        break;
        
        case 'grdWIDetail' :
            for ( var i = 1; i < grdWIDetail.rows; i++ )
            {
                if ( grdWIDetail.GetGridControl().isSelected(i) == true )
                {
                    if ( grdWIDetail.GetGridData( i, G1_PACK_WI_M_PK) == '' )
                    {
                        grdWIDetail.RemoveRowAt(i);                 
                    }   
                    else
                    {
                        grdWIDetail.DeleteRow();  
                    } 
                }    
            }            
        break;
        
    }
}

//=======================================================================
 function CheckInput(obj)
 { 
    var  row, col;
   
    switch (obj.id)
    {
        case 'grdWIDetail':
            row = event.row ;
            col = event.col ;    
            
            if ( col == G1_WI_QTY )
            {
                var dQuantiy;
                
                dQuantiy =  grdWIDetail.GetGridData(row,col)
                
                if (Number(dQuantiy))
                {   
                    if (dQuantiy >0)
                    {
                        grdWIDetail.SetGridText(row,col,parseFloat(dQuantiy+"").toFixed(0));
                    }
                    else
                    {
                        alert(" Value must greater than zero !!");
                        grdWIDetail.SetGridText(row,col,"")
                    }
                }
                else
                {
                    grdWIDetail.SetGridText(row,col,"")
                }         
                //---------------------------------------------
                grdWIDetail.Subtotal( 0, 2, -1, '13','###,###,###');
            }         
        break;
    }        
 }
//=========================================================================

function OnPrint(pos)
{
    switch (pos)
    {
        case 'Label' : 
            if(txtWIMasterPK.text=="")
            {
                alert("Please select WI No!");
            }
            else
            {
                  
                 var url = System.RootURL + "/form/ds/ep/dsep00076.aspx?pa_packages_wi_pk=" + txtWIMasterPK.text;
	             var object = System.OpenModal( url ,400 , 225,  'resizable:yes;status:yes', this);         
                
            }
        break;
    }
}

//=========================================================================

</script>

<body>
    <gw:data id="data_dsep00070_header" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" parameter="0,1,2"  function="<%=l_user%>lg_sel_dsep00070_header" > 
                <input bind="grdHeader">
                </input>
                <output  bind="grdHeader" />
            </dso> 
        </xml>
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_dsep00070" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12"  function="<%=l_user%>lg_sel_dsep00070" procedure="<%=l_user%>lg_upd_dsep00070">
                <inout>
                    <inout bind="txtWIMasterPK" /> 
                    <inout bind="txtWINo" />     
                    <inout bind="dtWIDate" />                     
                    <inout bind="txtPONo" /> 
                    <inout bind="txtArraySOPK" /> 
                    <inout bind="txtChargerPK" />                    
                    <inout bind="txtChargerNm" />
                    <inout bind="txtStylePK" />
                    <inout bind="txtStyleName" />
                    <inout bind="lstAtt01" />
                    <inout bind="txtDescription" /> 
                    <inout bind="lblWIStatus" />     
                    <inout bind="lblClose" />         
                 </inout>
            </dso>
        </xml>
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_dsep00070_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18"  function="<%=l_user%>lg_sel_dsep00070_1"  procedure="<%=l_user%>lg_upd_dsep00070_1"> 
                <input bind="grdWIDetail">
                    <input bind="txtWIMasterPK" />
                </input>
                <output  bind="grdWIDetail" />
            </dso> 
        </xml>
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_fpab00220_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="<%=l_user%>lg_sel_fpab00220_2" > 
                <input> 
                    <input bind="txtLGGroupCodeID" />
                </input>
	           <output>
	                <output bind="txtLGCodeList" /> 
	           </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_dsep00070_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" parameter="0,1,2"  function="<%=l_user%>lg_sel_dsep00070_2" > 
                <input bind="grdPackages">
                    <input bind="txtWIMasterPK" />
                </input>
                <output  bind="grdPackages" />
            </dso> 
        </xml>
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_dsep00070_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" parameter="0,1,2"  function="<%=l_user%>lg_sel_dsep00070_3" > 
                <input bind="grdPackagesItem">
                    <input bind="txtWIMasterPK" />
                    <input bind="txtASSL" />
                    <input bind="txtPackagesTypePK" />
                </input>
                <output  bind="grdPackagesItem" />
            </dso> 
        </xml>
    </gw:data>
    <!-------------------------------------------------------------------->
    <table style="width: 100%; height: 100%">
        <tr>
            <td id="t-left" style="width: 54%; white-space: nowrap">
                <table style="width: 100%; height: 100%" border="1">
                    <tr style="height: 1%">
                        <td>
                            <table style="width: 100%; height: 100%">
                                <tr style="height: 1%">
                                    <td align='right' style="width: 10%; white-space: nowrap">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('WINo')">W/I No</b>
                                    </td>
                                    <td style="width: 40%">
                                        <gw:textbox id="txtWINo" styles='width:100%' />
                                    </td>
                                    <td align='right' style="width: 10%; white-space: nowrap">
                                        W/I Date
                                    </td>
                                    <td style="width: 20%">
                                        <gw:datebox id="dtWIDate" lang="1" styles="width:100%" />
                                    </td>
                                    <td style="width: 15%; white-space: nowrap" align="center">
                                        <gw:label id="lblClose" styles='width:100%;color:cc0000;font:9pt' text='' />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="ibtnSearch01" img="search" alt="Seacrh" styles='width:100%' onclick="OnSearch('Master')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="ibtnPopUp" img="popup" alt="Open Popup" onclick="OnPopUp('WINo')"
                                            styles='width:100%' />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="ibtnReset" img="new" alt="new" styles='width:100%' onclick="OnAddNew('WI_MASTER')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="ibtnDelete" img="delete" alt="delete" styles='width:100%' onclick="OnDelete('WI_MASTER')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="ibtnUpdate" img="save" alt="save" styles='width:100%' onclick="OnSave('data_dsep00070')" />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td align='right' style="width: 10%; white-space: nowrap">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('SO')">P/O No</b>
                                    </td>
                                    <td style="width: 40%">
                                        <gw:textbox id="txtArraySOPK" styles='width:100%; display:none' />
                                        <gw:textbox id="txtPONo" styles='width:100%' csstype="mandatory" />
                                    </td>
                                    <td align='right' style="width: 10%; white-space: nowrap">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Charger')">Charger</b></td>
                                    <td style="width: 70%" colspan="7">
                                        <gw:textbox id="txtChargerPK" styles='width:100%;display:none' />
                                        <gw:textbox id="txtChargerNm" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr>
                                    <td align='right' style="width: 10%; white-space: nowrap">
                                        Style
                                    </td>
                                    <td style="width: 40%" colspan="9">
                                        <gw:textbox id="txtStylePK" styles='width:100%; display:none' />
                                        <gw:textbox id="txtStyleName" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr>
                                    <td align='right' style="width: 10%; white-space: nowrap">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Att01')">Att01</b>
                                    </td>
                                    <td style="width: 40%" colspan="9">
                                        <gw:list id="lstAtt01" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td align='right' style="width: 10%; white-space: nowrap">
                                        Remark</td>
                                    <td style="width: 40%" colspan="4">
                                        <gw:textbox id="txtDescription" styles='width:100%' />
                                    </td>
									
                                    <td style="width: 99%" colspan="3" align="center">
                                        <gw:label id="lblWIStatus" styles='width:100%;color:cc0000;font:9pt' text='status' />
                                    </td>
									 <td style="width: 1%;">
                                        <gw:imgbtn id="ibtnNewDtl" img="new" alt="New" onclick="OnAddNew('FreeItem')"
                                            styles='width:100%' />
                                    </td>									
                                    <td style="width: 1%;">
                                        <gw:imgbtn id="ibtnDelDtl" img="delete" alt="Delete" onclick="OnDelete('grdWIDetail')"
                                            styles='width:100%' />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td>
                            <gw:grid id='grdWIDetail' header='_SO_PK|_SOD_PK|P/O No|_SPEC01_PK|Spec 01|_SPEC02_PK|Spec 02|_SPEC03_PK|Spec 03|_SPEC04_PK|Spec 04|_SPEC05_PK|Spec 05|Pack Qty|Packed Qty|Bal Qty|Remark|_PA_PACKING_WI_PK|_PK'
                                format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|1|0|1|0|1|0|1|0|1|3|3|3|0|0|0'
                                defaults='||||||||||||||||||' editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|1|0|0|0|0|0'
                                widths='0|0|1200|0|1500|0|1500|0|1500|0|1500|0|1500|1200|1200|1200|0|0|0' sorting='T'
                                styles='width:100%; height:100%' onafteredit="CheckInput(this)" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 2%; white-space: nowrap" align="center">
                <img status="expand" id="imgArrow1" src="../../../system/images/button/previous.gif"
                    style="cursor: hand" onclick="OnToggle('1')" />
                <img status="expand" id="imgArrow2" src="../../../system/images/button/next.gif"
                    style="cursor: hand" onclick="OnToggle('2')" />
            </td>
            <td id="t-right" style="width: 44%; height: 100%">
                <table style="width: 100%; height: 100%" border="1">
                    <tr style="width: 100%; height: 45%">
                        <td>
                            <table style="width: 100%; height: 100%">
                                <tr>
                                    <td style="width: 1%; white-space: nowrap">
                                        <gw:checkbox id="chkAllItem" defaultvalue="Y|N" value="Y" onchange="" />
                                        All Item</td>
                                    <td style="width: 1%">
                                        <gw:icon id="ibtnPackingType" img="2" text="Packing Type" alt="Generate Packages from Packing Type"
                                            onclick="OnPopUp('PackingType')" styles='width:100%' />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:icon id="ibtnMakePackages" img="2" text="Packages" alt="Make Packages for remain item"
                                            onclick="OnPopUp('MakePackages')" styles='width:100%' />
                                    </td>
                                    <td style="width: 93%">
                                    </td>
                                    <td style="width: 1%">
                                    </td>
                                    <td style="width: 1%">
                                        <gw:icon id="ibtnPrintLabel" img="2" text="Print Label" alt="Print Label" onclick="OnPrint('Label')"
                                            styles='width:100%' />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="ibtnSearch" img="search" alt="Seacrh" styles='width:100%' onclick="OnSearch('grdPackages')" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn id="btnReport" img="excel" alt="Print" text="Print" onclick="OnReportClick()" />
                                    </td>
                                </tr>
                                <tr style="height: 100%">
                                    <td colspan="8">
                                        <gw:grid id='grdPackages' header='AS/SL|_PackagesPK|Code|Name|Packages' format='0|0|0|0|0'
                                            aligns='1|0|1|1|0' defaults='||||' editcol='0|0|0|0|0' widths='1000|0|1200|1800|1000'
                                            sorting='T' styles='width:100%; height:100%' oncellclick="OnSearch('grdPackagesItem')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="width: 100%; height: 55%">
                        <td>
                            <gw:grid id='grdPackagesItem' header='_SPEC01_PK|Spec 01|_SPEC02_PK|Spec 02|_SPEC03_PK|Spec 03|_SPEC04_PK|Spec 04|_SPEC05_PK|Spec 05|Qty'
                                format='0|0|0|0|0|0|0|0|0|0|0' aligns='0|1|0|1|0|1|0|1|0|1|3' defaults='||||||||||'
                                editcol='0|0|0|0|0|0|0|0|0|0|0' widths='1000|1200|1000|1200|1000|1200|1000|1200|1000|1200|1000'
                                sorting='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<!------------------------------------------------------------------------------->
<gw:textbox id="txtWIMasterPK" styles='display:none;width:100%' />
<gw:textbox id="txtWIDetailPK" styles='display:none;width:100%' />
<!------------------------------------------------------------------------------->
<gw:textbox id="txtASSL" styles='display:none;width:100%' />
<gw:textbox id="txtPackagesTypePK" styles='display:none;width:100%' />
<!------------------------------------------------------------------------------->
<gw:textbox id="txtReturnValue" styles='display:none;width:100%' />
<!------------------------------------------------------------------------------->
<gw:textbox id="txtLGCodeList" styles='display:none;width:100%' />
<gw:textbox id="txtLGGroupCodeID" styles='display:none;width:100%' />

<gw:grid id='grdHeader' header='PK|GRID_TYPE|COL01_HEADER|COL01_DISPLAY|COL02_HEADER|COL02_DISPLAY|COL03_HEADER|COL03_DISPLAY|COL04_HEADER|COL04_DISPLAY|COL05_HEADER|COL05_DISPLAY|DESCRIPTION'
    format='0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0|0|0|0|0|0' check='||||||||||||'
    editcol='1|1|1|1|1|1|1|1|1|1|1|1|1' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
    sorting='T' autosize='T' styles='width:100%; height:460;display:none' />
<!------------------------------------------------------------------------------->
</html>
