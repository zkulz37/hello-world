<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Packing Type Entry</title>
</head>
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<script>
var userID = "";
    userID ="<%=Session("LoginID")%>";
    
var p_action='view';

var G1_Packing_Type_PK  = 0,
    G1_Code             = 1,
    G1_Name             = 2,
    G1_REMARK           = 3;

var G2_Seq          = 0,
    G2_SPEC01_PK    = 1,
    G2_SPEC01_NM    = 2,
    G2_GRP01        = 3,
    G2_SPEC02_PK    = 4,
    G2_SPEC02_NM    = 5,
    G2_GRP02        = 6,
    G2_SPEC03_PK    = 7,
    G2_SPEC03_NM    = 8,
    G2_GRP03        = 9,
    G2_SPEC04_PK    = 10,
    G2_SPEC04_NM    = 11,
    G2_GRP04        = 12,
    G2_SPEC05_PK    = 13,
    G2_SPEC05_NM    = 14,
    G2_GRP05        = 15,
    G2_Pack_Qty     = 16,
    G2_Type         = 17,   
    G2_Net_Weight   = 18,
    G2_Gross_Weight = 19, 
    G2_REMARK  		= 20,    
    G2_Packing_Type_PK = 21,
    G2_Solid_PK     = 22;
    
        
var G3_Assort_No    = 0,
    G3_SPEC01_PK    = 1,
    G3_SPEC01_NM    = 2,
    G3_GRP01        = 3,
    G3_SPEC02_PK    = 4,
    G3_SPEC02_NM    = 5,
    G3_GRP02        = 6,
    G3_SPEC03_PK    = 7,
    G3_SPEC03_NM    = 8,
    G3_GRP03        = 9,
    G3_SPEC04_PK    = 10,
    G3_SPEC04_NM    = 11,
    G3_GRP04        = 12,
    G3_SPEC05_PK    = 13,
    G3_SPEC05_NM    = 14,
    G3_GRP05        = 15,
    G3_Pack_Qty     = 16,
    G3_TYPE         = 17,       
    G3_REMARK  		= 18,    
    G3_Packing_Type_PK = 19,
    G3_Assort_PK    = 20;
 
var G4_TLG_PA_PACKING_TYPE_PK       = 0,
    G4_TLG_PA_PACKING_TYPE_ITEM_PK  = 1,
    G4_SEQ                          = 2,
    G4_TLG_IT_STITEM_PK             = 3,
    G4_TLG_IT_ITEM_PK               = 4,
    G4_ITEM_CODE                    = 5,
    G4_ITEM_NAME                    = 6,
    G4_PACK_QTY                     = 7,
    G4_DESCRIPTION                  = 8;
//====================================================================
function BodyInit()
{
    //-----------------------------       
    System.Translate(document);
    txtCoverID.SetEnable(false);
    txtCoverNM.SetEnable(false);

    txtItemCode.SetEnable(false);
    txtItemName.SetEnable(false);
    //----------------------------- 
    FormatGrid();
    OnChangeTab();     
    //-----------------------------  
    OnSearch('grdPackingType'); 
    //-----------------------------   
}
//===================================================================
function FormatGrid()
{
    grdAssort.GetGridControl().Cell( 7, 0, G3_Assort_No, 0, G3_Assort_No) = 0x3300cc;
    grdAssort.GetGridControl().Cell( 7, 0, G3_TYPE, 0, G3_TYPE) = 0x3300cc;
    
    grdSolid.GetGridControl().Cell( 7, 0, G2_Type, 0, G2_Type) = 0x3300cc;
    
    grdSolid.GetGridControl().ColFormat(G2_Pack_Qty)  = "###,###,###,###";
    
    grdSolid.GetGridControl().ColFormat(G2_Net_Weight)  = "###,###,###,###.##";
    grdSolid.GetGridControl().ColFormat(G2_Gross_Weight)= "###,###,###,###.##";
    
    grdAssort.GetGridControl().ColFormat(G3_Pack_Qty) = "###,###,###,###";

    var data ="#1;Pack enough qty|#2;Pack Remaining qty"
    grdSolid.SetComboFormat( G2_Type, data); 
    grdAssort.SetComboFormat( G3_TYPE, data); 
    
    data = "data|1|1|2|2|3|3|4|4|5|5|6|6|7|7||";
    lstAssortType.SetDataText(data);    
    lstAssortType.value = '';
}

//====================================================================
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'data_dsep00080_1':
            OnSearch('data_dsep00080_2');
        break;
        
        case "data_dsep00080_2":
            if ( t_view == 'Y' )
            {
                OnSearch('grdSolid');
            }
        break;
        
        case "data_dsep00080_3":
            //-----------------
            if ( grdSolid.rows > 1 )
            {
                grdSolid.SetCellBold( 1, G2_Pack_Qty, grdSolid.rows - 1, G2_Pack_Qty, true);              
            }
            //------------------        
            if ( t_view == 'Y' )
            {
                t_view = 'N' ;
                OnSearch('grdAssort');
            }
        break; 
        
        case "data_dsep00080_4":
            if ( grdAssort.rows > 1 )
            {
                grdAssort.SetCellBgColor( 1, G3_Assort_No , grdAssort.rows - 1, G3_Assort_No , 0xCCFFFF );
                grdAssort.SetCellBold( 1, G3_Pack_Qty, grdAssort.rows - 1, G3_Pack_Qty, true);              
            }
            OnSearch('grdItem');
        break;  
        
        case "data_dsep00080_5":
            grdItem.SetCellBold( 1, G4_PACK_QTY, grdItem.rows - 1, G4_PACK_QTY, true);               
        break;               
    }
}
//====================================================================
function OnPopUp(id)
{
    switch (id)
    {
        case 'PackagesType':
             var path = System.RootURL + '/form/ds/ep/dsep00010.aspx?';
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if (object!= null)
	         {
	            txtCoverPK.text = object[0]
	            txtCoverID.text = object[1]
	            txtCoverNM.text = object[2]
	         }
        break;               
        
        case 'Detail' :
            var t_col = event.col ;
            var t_row = event.row ;
            

            var strRad = radPackType.GetData();
                         
            switch (strRad)
            {
                case 'SL': 
                    if ( t_col == G2_SPEC01_NM || t_col == G2_SPEC02_NM || t_col == G2_SPEC03_NM || t_col == G2_SPEC04_NM || t_col == G2_SPEC05_NM)   
                    {  
                        var path = System.RootURL + '/form/fp/ab/fpab00090.aspx?group_type=1';
                        var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
                        
                        if ( object != null )
                        {                                   
                            grdSolid.SetGridText( t_row, t_col  , object[4] );
                            grdSolid.SetGridText( t_row, t_col-1, object[2] );  
                        }    	         
                    }                  
                break;
                
                case 'AS':
                    if ( t_col == G3_SPEC01_NM || t_col == G3_SPEC02_NM || t_col == G3_SPEC03_NM || t_col == G3_SPEC04_NM || t_col == G3_SPEC05_NM)   
                    { 
                        var path = System.RootURL + '/form/fp/ab/fpab00090.aspx?group_type=1';
                        var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
                        
                        if ( object != null )
                        {                                                                               
                            grdAssort.SetGridText( t_row, t_col  , object[4] );
                            grdAssort.SetGridText( t_row, t_col-1, object[2] );  
                        }    	         
                    }                   
                break;
            }                    
        break;

        case 'Items':
            if(txtPackingTypePK.text == '')
            {
                alert('Pls select one packing type!');
                return;
            }

            var path = System.RootURL + '/form/fp/ab/fpab00350.aspx?group_type=|Y|||Y|Y';
	        var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	        if (object!= null)
	        {
               var arrTemp;
	           for( var a = 0; a < object.length; a++)
               {
                    arrTemp = object[a];
                    grdItem.AddRow();

                    grdItem.SetGridText( grdItem.rows-1, G4_SEQ, grdItem.rows-1);
                    grdItem.SetGridText( grdItem.rows-1, G4_TLG_PA_PACKING_TYPE_PK, txtPackingTypePK.text);

                    grdItem.SetGridText( grdItem.rows-1, G4_TLG_IT_STITEM_PK, arrTemp[0]);
                    grdItem.SetGridText( grdItem.rows-1, G4_TLG_IT_ITEM_PK, arrTemp[1]);
                    grdItem.SetGridText( grdItem.rows-1, G4_ITEM_CODE, arrTemp[2]);
                    grdItem.SetGridText( grdItem.rows-1, G4_ITEM_NAME, arrTemp[3]);
               }
	        }
        break;

        case 'Item':
            var path = System.RootURL + '/form/fp/ab/fpab00110.aspx?group_type=|Y|||Y|Y';
	        var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	        if (object!= null)
	        {
                if ( object != null )
                {
                    txtItemPK.text      = object[0];
                    txtItemCode.text    = object[1];
                    txtItemName.text    = object[2];
                }
	        }
        break;
    }
}
//====================================================================

var t_view = "N" ;
//--------------------------------------------------------------------
function OnSearch(id)
{
    switch(id)
    {
        case 'grdPackingType':
            data_dsep00080.Call("SELECT");
        break;
        
        case 'treePackingType':        
            if ( grdPackingType.row > 0 )
            {
                p_action = 'view';
                txtPackingTypePK.text = grdPackingType.GetGridData( grdPackingType.row, G1_Packing_Type_PK );
                data_dsep00080_1.Call('SELECT');
            }            
        break;
        
        case 'data_dsep00080_2':                    	
            if ( treePackingType.GetCurrentNode()!= null )
            {
                var obj = treePackingType.GetCurrentNode();
	            txtPackTypeDetailPK.text = obj.oid;
	        }    
	        else
	        {
	            txtPackTypeDetailPK.text = '' ;
	        }
	        
	        data_dsep00080_2.Call("SELECT");
        break;
        
        case 'grdSolid':
            data_dsep00080_3.Call("SELECT");
        break;
        
        case 'grdAssort':
            data_dsep00080_4.Call("SELECT");
        break;   
        
        case 'grdItem':
            data_dsep00080_5.Call("SELECT");
        break;               
    }
}
//====================================================================

function OnCellClk(obj)
{
    switch (obj.id)
    {
        case 'grdPackingType':
            t_view = 'Y' ;
            OnSearch('treePackingType');
            lbName.text=(grdPackingType.GetGridData(grdPackingType.row,G1_Code)+" - "+grdPackingType.GetGridData(grdPackingType.row,G1_Name));
        break;
    }
}
//====================================================================
function OnAddNew(id)
{
    switch(id)
    {   
        case 'grdPackingType': // reset all
             grdPackingType.AddRow();
        break;
        
        case 'Parent'://reset label type
            
             txtPackTypeDetailPK.text = "";
             txtCoverPK.text = "";
	         txtCoverID.text = "";
	         txtCoverNM.text = "";
        	 
	         txtParentPK.text ="";
	         txtDefaultQty.text = 1
             data_dsep00080_2.StatusInsert();
             txtPackingTypePK01.text = txtPackingTypePK.text;             
             p_action ='update';
        break;
        
        case 'Child'://add sub
            var temp1;
            temp1 = txtPackTypeDetailPK.text ;
            
            data_dsep00080_2.StatusInsert();
            
            p_action ='update';
            
            txtParentPK.SetDataText(temp1);
            
            txtPackingTypePK01.text = txtPackingTypePK.text;
            
        	txtPackTypeDetailPK.text =""
            txtCoverPK.text = ""
	        txtCoverID.text = ""
	        txtCoverNM.text = ""
        	
        	txtDefaultQty.text = 1;
	        
        break;
        
        case 'Item':
            if ( txtPackingTypePK.text != '' )
            {        
                var strRad = radPackType.GetData();
                             
                switch (strRad)
                {
	                case 'SL': 
                        grdSolid.AddRow();
                        grdSolid.SetGridText( grdSolid.rows-1, G2_Packing_Type_PK, txtPackingTypePK.text);	         
	                break;
	                
	                case 'AS':
                        grdAssort.AddRow();
                        grdAssort.SetGridText( grdAssort.rows-1, G3_Packing_Type_PK, txtPackingTypePK.text);	         
	                break;
	            } 
	        }              
            else
            {
                alert("Please select saved packing type!");
            }
        break;
    }
    
}
//====================================================================

function OnSave(index)
{
    switch(index)
    {
        case 'grdPackingType':
                data_dsep00080.Call();
        break;
        
        case 'PackingTypeDetail':
            if ( OnValidateData('PackingTypeDetail') )
            {
                data_dsep00080_2.Call();
            }
        break;
        
        case 'Item':
            var strRad = radPackType.GetData();
                         
            switch (strRad)
            {
                case 'SL': 
                    data_dsep00080_3.Call() ;
                break;
                
                case 'AS':
                    data_dsep00080_4.Call() ;	         
                break;
            }
        break;

        case 'Items':
            data_dsep00080_5.Call() ;	 
        break;
    }
}
//====================================================================
function OnToggle()
 {
    var left  = document.all("left");    
    var right = document.all("right");   
    var imgArrow = document.all("imgArrow");   
    
    if(imgArrow.status == "expand")
    {
        left.style.display="none";       
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="75%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }
//====================================================================
function OnDelete(obj)
{
    switch(obj)
    {
        case 'grdPackingType' :
            for ( var i = 1; i < grdPackingType.rows; i++ )
            {
                if ( grdPackingType.GetGridControl().isSelected(i) == true )
                {
                    if ( grdPackingType.GetGridData( i, G1_Packing_Type_PK) == '' )
                    {
                        grdPackingType.RemoveRowAt(i);                 
                    }   
                    else
                    {
                        grdPackingType.DeleteRow();  
                    } 
                }    
            }
        break; 

        case 'grdItem' :
            for ( var i = 1; i < grdItem.rows; i++ )
            {
                if ( grdItem.GetGridControl().isSelected(i) == true )
                {
                    if ( grdItem.GetGridData( i, G4_TLG_PA_PACKING_TYPE_ITEM_PK) == '' )
                    {
                        grdItem.RemoveRowAt(i);                 
                    }   
                    else
                    {
                        grdItem.DeleteRow();  
                    } 
                }    
            }
        break; 
                
        case 'Item' :
            var strRad = radPackType.GetData();
            var grdTmp;
                         
            switch (strRad)
            {
                case 'SL':                      
					for ( var i = 1; i < grdSolid.rows; i++ )
		            {
		                if ( grdSolid.GetGridControl().isSelected(i) == true )
		                {
		                    if ( grdSolid.GetGridData( i, G2_Solid_PK) == '' )
		                    {
		                        grdSolid.RemoveRowAt(i);                 
		                    }   
		                    else
		                    {
		                        grdSolid.DeleteRow();  
		                    } 
		                }    
		            }          
                break;
                
                case 'AS':
                    
					for ( var i = 1; i < grdAssort.rows; i++ )
		            {
		                if ( grdAssort.GetGridControl().isSelected(i) == true )
		                {
		                    if ( grdAssort.GetGridData( i, G3_Assort_PK) == '' )
		                    {
		                        grdAssort.RemoveRowAt(i);                 
		                    }   
		                    else
		                    {
		                        grdAssort.DeleteRow();  
		                    } 
		                }    
		            }     						         
                break;
            }
            
                       
        break;
        
        case 'PackingTypeDetail' :
            if ( confirm('Do you want to delete this detail?') )
            {
                p_action ='update';
                data_dsep00080_2.StatusDelete();
                data_dsep00080_2.Call();
            }
        break;       
    }

}
//====================================================================
function OnUnDelete(obj)
{
    switch(obj)
    {
        case 'grdPackingType' :
            grdPackingType.UnDeleteRow();  
        break; 

        case 'grdItem' :
            grdItem.UnDeleteRow();  
        break; 
                
        case 'Item':
            var strRad = radPackType.GetData();
                     
	        switch (strRad)
	        {
	            case 'SL':
	                grdSolid.UnDeleteRow();
	            break;
	            
	            case 'AS':
	                grdAssort.UnDeleteRow();
	            break;
            }
        break;       
    }

}
//====================================================================
function OnValidateData(index)
{
    switch(index)
    {
        case 'PackingTypeDetail':
            if( txtCoverPK.text == '' )
            {
                alert('Please input packages type!!!');
                return false;
            }
            
            if( txtDefaultQty.text == '0' || txtDefaultQty.text == '')
            {
                alert('Please input qty.!!!');
                return false;
            }
        break;       
    }
    return true;
}
//=================================================================
 function OnChangeTab()
 {
 
    var strRad = radPackType.GetData();
             
	switch (strRad)
	{
		case 'SL':
		    grdSolid.style.display      = "";
		    grdAssort.style.display     = "none";
		    lstAssortType.style.display = "none";
		    
		    tab_Solid.style.color  = "cc0000"; 
		    tab_Assort.style.color = "";
		    
        break;
        
        case 'AS':
		    grdSolid.style.display      = "none";
		    grdAssort.style.display     = "";
		    lstAssortType.style.display = "";
		    
		    tab_Solid.style.color  = ""; 
		    tab_Assort.style.color = "cc0000";
		   		    
        break;	
    } 
 }
 //=======================================================================
 function CheckInput(obj)
 { 
    var  row, col;
   
    switch (obj.id)
    {
        case 'grdSolid':
            row = event.row ;
            col = event.col ;    
            
            if ( col == G2_Pack_Qty || col == G2_Net_Weight || col == G2_Gross_Weight )
            {
                var dQuantiy;
                
                dQuantiy =  grdSolid.GetGridData(row,col)
                
                if (Number(dQuantiy))
                {   
                    if (dQuantiy >0)
                    {
                        if ( col == G2_Pack_Qty )
                        {
                            grdSolid.SetGridText(row,col,parseFloat(dQuantiy+"").toFixed(0));
                        }
                        else ( col == G2_Net_Weight || col == G2_Gross_Weight )
                        {
                            grdSolid.SetGridText(row,col,parseFloat(dQuantiy+"").toFixed(2));
                        }    
                    }
                    else
                    {
                        alert(" Value must greater than zero !!");
                        grdSolid.SetGridText(row,col,"")
                    }
                }
                else
                {
                    grdSolid.SetGridText(row,col,"")
                }         
            }         
        break;
        
        case 'grdAssort':
            row = event.row ;
            col = event.col ;    
            
            if ( col == G2_Pack_Qty )
            {
                var dQuantiy;
                
                dQuantiy =  grdAssort.GetGridData(row,col)
                
                if (Number(dQuantiy))
                {   
                    if (dQuantiy >0)
                    {
                        grdAssort.SetGridText(row,col,parseFloat(dQuantiy+"").toFixed(0));
                    }
                    else
                    {
                        alert(" Value must greater than zero !!");
                        grdAssort.SetGridText(row,col,"")
                    }
                }
                else
                {
                    grdAssort.SetGridText(row,col,"")
                }         
            }         
        break;        
    }        
 }
//====================================================================
</script>
<body>
    <!-------------------------------------------------------------->
    <gw:data id="data_dsep00080" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2,3" function="<%=l_user%>lg_sel_dsep00080" procedure="<%=l_user%>lg_upd_dsep00080" > 
                <input bind="grdPackingType"  > 
                    <input bind="txtPackType"/> 
                </input> 
                <output bind="grdPackingType" /> 
            </dso>            
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------->
    <gw:data id="data_dsep00080_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="tree" function="<%=l_user%>lg_sel_dsep00080_1" > 
                <input>
                    <input bind="txtPackingTypePK" /> 
                </input> 
                <output bind="treePackingType" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------->
    <gw:data id="data_dsep00080_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12"  function="<%=l_user%>lg_sel_dsep00080_2" procedure="<%=l_user%>lg_upd_dsep00080_2">
                <inout>
                    <inout  bind="txtPackTypeDetailPK"/>
                    <inout  bind="txtPackingTypePK01"/>
                    <inout  bind="txtParentPK"/>
                    <inout  bind="txtCoverPK"/>
                    <inout  bind="txtCoverID"/>
                    <inout  bind="txtCoverNM"/>
                    <inout  bind="txtItemPK"/>
                    <inout  bind="txtItemCode"/>
                    <inout  bind="txtItemName"/>
                    <inout  bind="chkItemYN" />                   
                    <inout  bind="txtDefaultQty"  />   
                    <inout  bind="txtDescription"  />
                    <inout  bind="chkLeafYN" />         
                 </inout>
            </dso>
        </xml>
    </gw:data>
    <!-------------------------------------------------------------->
    <gw:data id="data_dsep00080_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22" function="<%=l_user%>lg_sel_dsep00080_3" procedure="<%=l_user%>lg_upd_dsep00080_3"> 
                <input bind="grdSolid"  > 
                    <input bind="txtPackingTypePK"/> 
                </input> 
                <output bind="grdSolid" /> 
            </dso>            
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------->
    <gw:data id="data_dsep00080_4" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20" function="<%=l_user%>lg_sel_dsep00080_4" procedure="<%=l_user%>lg_upd_dsep00080_4"> 
                <input bind="grdAssort"  > 
                    <input bind="txtPackingTypePK"/> 
                    <input bind="lstAssortType"/>
                </input> 
                <output bind="grdAssort" /> 
            </dso>            
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------->
    <gw:data id="data_dsep00080_5" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8" function="<%=l_user%>lg_sel_dsep00080_5" procedure="<%=l_user%>lg_upd_dsep00080_5"> 
                <input bind="grdItem"  > 
                    <input bind="txtPackingTypePK"/> 
                </input> 
                <output bind="grdItem" /> 
            </dso>            
        </xml> 
    </gw:data>
    <!------------------------- MainTable -------------------------->
    <table style="height: 100%; width: 100%">
        <tr style="height: 100%; width: 100%">
            <td style="width: 30%" id="left">
                <table style="height: 100%; width: 100%">
                    <tr style="height: 1%">
                        <td style="width: 20%; white-space: nowrap">
                            Packing Type
                        </td>
                        <td style="width: 80%" colspan="6">
                            <gw:textbox id="txtPackType" csstype="mandatory" text="" styles='width:98%' onenterkey="OnSearch('grdPackingType')" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 20%">
                        </td>
                        <td style="width: 75%">
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibnSearch01" img="search" alt="Search" styles='width:100%' onclick="OnSearch('grdPackingType')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibnNew01" img="new" alt="new" styles='width:100%' onclick="OnAddNew('grdPackingType')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibnDelete01" img="delete" alt="delete" styles='width:100%' onclick="OnDelete('grdPackingType')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibnUnDelete01" img="udelete" alt="UnDelete" styles='width:100%' onclick="OnUnDelete('grdPackingType')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibnUpdate01" img="save" alt="save" styles='width:100%' onclick="OnSave('grdPackingType')" />
                        </td>
                    </tr>
                    <tr style="height: 99%; width: 100%">
                        <td colspan="7">
                            <gw:grid id="grdPackingType" header="_PK|Code|Name|Remark" format="0|0|0|0" aligns="0|0|0|0"
                                defaults="|||" editcol="0|1|1|1" widths="0|1200|3000|0" styles="width:100%; height:100%"
                                sorting="T" acceptnulldate="true" param="0,1,2,3" oncellclick="OnCellClk(this)" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right">
                <table style="height: 100%; width: 100%" border="1">
                    <tr style="height: 40%">
                        <td style="width: 30%">
                            <table style="height: 100%; width: 100%; background-color: #FFFFCC">
                                <tr style="height: 1%">
                                    <td style="width: 96%; color: DarkRed; font-size: small; white-space: nowrap">
                                        Packing Type Detail
                                    </td>
                                </tr>
                                <tr style="height: 99%">
                                    <td>
                                        <gw:tree id="treePackingType" style="width: 100%; height: 100%; overflow: auto;"
                                            onclicknode="OnSearch('data_dsep00080_2')" dragmode="false">
						    </gw:tree>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table style="height: 100%; width: 100%">
                                <tr style="height: 1%">
                                    <td colspan="2">
                                        <table style="height: 100%; width: 100%">
                                            <tr>
                                                <td style="width: 96%">
                                                    <gw:label id="lbName" text="" styles='width:100%;color:red;height:100%' />
                                                </td>
                                                <td style="width: 1%">
                                                    <gw:imgbtn id="ibtnResetDtl" img="new" alt="new" onclick="OnAddNew('Parent')" styles='width:100%' />
                                                </td>
                                                <td style="width: 1%">
                                                    <gw:imgbtn id="ibtnReset_Sub" img="new_sub" alt="newsub" onclick="OnAddNew('Child')"
                                                        styles='width:100%' />
                                                </td>
                                                <td style="width: 1%">
                                                    <gw:imgbtn id="ibtnDeleteDtl" img="delete" alt="delete" onclick="OnDelete('PackingTypeDetail')"
                                                        styles='width:100%' />
                                                </td>
                                                <td style="width: 1%">
                                                    <gw:imgbtn id="ibtnUpdateDtl" img="save" alt="save" onclick="OnSave('PackingTypeDetail')"
                                                        styles='width:100%' />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('PackagesType')">&nbsp;&nbsp;Package
                                            Type </b>
                                    </td>
                                    <td style="width: 90%; white-space: nowrap">
                                        <gw:textbox id="txtCoverPK" text="" styles="display:none" />
                                        <gw:textbox id="txtCoverID" text="" csstype="mandatory" styles='width:30%' />
                                        <gw:textbox id="txtCoverNM" text="" csstype="mandatory" styles='width:70%' />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="width: 90%; white-space: nowrap" align="left" colspan="2">
                                        <table style="height: 100%; width: 100%">
                                            <tr>
                                                <td style="width: 25%; white-space: nowrap" align="right">
                                                    Item Y/N
                                                </td>
                                                <td style="width: 25%" align="left">
                                                    <gw:checkbox id="chkItemYN" styles="color:blue" defaultvalue="Y|N" value="Y"></gw:checkbox>
                                                </td>
                                                <td style="width: 25%" align="right">
                                                    Leaf Y/N
                                                </td>
                                                <td style="width: 25%" align="left">
                                                    <gw:checkbox id="chkLeafYN" styles="color:blue" defaultvalue="Y|N" value="Y"></gw:checkbox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="width: 25%; white-space: nowrap" align="right">
                                        <b style="color: #1b2ff2; cursor: hand;" onclick="OnPopUp('Item')">Item</b>
                                    </td>
                                    <td style="width: 25%" align="left">
                                        <gw:textbox id="txtItemPK" styles='display:none' />
                                        <gw:textbox id="txtItemCode" styles='width:30%' />
                                        <gw:textbox id="txtItemName" styles='width:70%' />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td align="right">
                                        Qty
                                    </td>
                                    <td>
                                        <gw:textbox id="txtDefaultQty" type="number" format="###,###.###" styles='width:30%;color:blue' />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        Remark
                                    </td>
                                    <td style="width: 90%; white-space: nowrap">
                                        <gw:textbox id="txtDescription" text="" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr style="height: 94%">
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <gw:tab id="tab">
                            <table name="Solid-Ass" style="height: 100%; width: 100%">
                                <tr style="height: 1%">
                                    <td style="width: 1%">
                                        <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand"
                                            onclick="OnToggle()" />
                                    </td>
                                    <td style="width: 49%; white-space: nowrap" align="center">
                                        <gw:radio id="radPackType" value="SL" styles="width:100%" onchange="OnChangeTab()"> 
                                            <span value="SL" id="tab_Solid" >Solid </span> 
                                            <span value="AS" id="tab_Assort">Assort</span> 
                                        </gw:radio>
                                    </td>
                                    <td style="width: 20%">
                                        <gw:list id="lstAssortType" styles='width:100%' onchange="OnSearch('grdAssort')" />
                                    </td>
                                    <td style="width: 26%">
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="ibtnAddItem" img="new" alt="Add Item" styles='width:100%' onclick="OnAddNew('Item')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="ibtnDeleteItem" img="delete" alt="Delete Item" onclick="OnDelete('Item')"
                                            styles='width:100%' />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="ibtnUnDeleteItem" img="udelete" alt="Un Delete Item" onclick="OnUnDelete('Item')"
                                            styles='width:100%' />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="ibtnUpdateItem" img="save" alt="Save Item" onclick="OnSave('Item')"
                                            styles='width:100%' />
                                    </td>
                                </tr>
                                <tr style="height: 99%">
                                    <td colspan="8">
                                        <gw:grid id='grdSolid' header='Seq|_SPEC01_PK|Spec 01|(*)|_SPEC02_PK|Spec 02|(*)|_SPEC03_PK|Spec 03|(*)|_SPEC04_PK|Spec 04|(*)|_SPEC05_PK|Spec 05|(*)|Pack Qty|Type|Net Weight|Gross Weight|Remark|_Packing_Type_PK|_PK'
                                            format='0|0|0|3|0|0|3|0|0|3|0|0|3|0|0|3|0|0|0|0|0|0|0' 
                                            aligns='1|0|1|0|0|1|0|0|1|0|0|1|0|0|1|0|3|0|3|3|0|0|0'
                                            defaults='||||||||||||||||||||||' 
                                            editcol='1|0|0|1|0|0|1|0|0|1|0|0|1|0|0|1|1|1|1|1|1|0|0'
                                            widths='1000|0|1500|600|0|1500|600|0|1500|600|0|1500|600|0|1500|600|1200|1500|1200|1200|1000|0|0'
                                            sorting='T' styles='width:100%; height:100%' 
                                            oncelldblclick="OnPopUp('Detail')"
                                            onafteredit="CheckInput(this)" />
                                        <gw:grid id='grdAssort' header='Assort No|_SPEC01_PK|Spec 01|(*)|_SPEC02_PK|Spec 02|(*)|_SPEC03_PK|Spec 03|(*)|_SPEC04_PK|Spec 04|(*)|_SPEC05_PK|Spec 05|(*)|Pack Qty|Type|Remark|_Packing_Type_PK|_PK'
                                            format='0|0|0|3|0|0|3|0|0|3|0|0|3|0|0|3|0|0|0|0|0' aligns='1|0|1|0|0|1|0|0|1|0|0|1|0|0|1|0|3|0|0|0|0'
                                            defaults='||||||||||||||||||||' editcol='1|0|0|1|0|0|1|0|0|1|0|0|1|0|0|1|1|1|1|0|0'
                                            widths='1000|0|1500|600|0|1500|600|0|1500|600|0|1500|600|0|1500|600|1200|1500|1000|0|0'
                                            sorting='T' oncelldblclick="OnPopUp('Detail')" styles='width:100%; height:100%'
                                            onafteredit="CheckInput(this)" />
                                    </td>
                                </tr>
                            </table>
                            <table name="Item" style="height: 100%; width: 100%">
                                <tr style="height: 1%">
                                    <td style="width: 1%">
                                        
                                    </td>
                                    <td style="width: 49%; white-space: nowrap" align="center">
                                       
                                    </td>
                                    <td style="width: 20%">
                                       
                                    </td>
                                    <td style="width: 26%">
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="ibtnAddItem1" img="new" alt="Add Item" styles='width:100%' onclick="OnPopUp('Items')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="ibtnDeleteItem1" img="delete" alt="Delete Item" onclick="OnDelete('grdItem')"
                                            styles='width:100%' />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="ibtnUnDeleteItem1" img="udelete" alt="Un Delete Item" onclick="OnUnDelete('grdItem')"
                                            styles='width:100%' />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="ibtnUpdateItem1" img="save" alt="Save Item" onclick="OnSave('Items')"
                                            styles='width:100%' />
                                    </td>
                                </tr>
                                <tr style="height: 99%">
                                    <td colspan="8">
                                        <gw:grid id='grdItem'
                                            header='_tlg_pa_packing_type_pk|_pk|Seq|_tlg_it_stitem_pk|_tlg_it_item_pk|Item Code|Item Name|Pack Qty|Description'
                                            format='0|0|0|0|0|0|0|1|0'
                                            aligns='0|0|1|0|0|0|0|0|0'
                                            check='||||||||'
                                            editcol='1|1|1|1|1|1|1|1|1'
                                            widths='0|0|500|0|0|1500|3500|1000|1000'
                                            sorting='T'
                                            styles='width:100%; height:100%'
                                            />
                                    </td>
                                </tr>
                            </table>
                        </gw:tab>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<!---------------------------------------------------------------->
<gw:textbox id="txtPackTypeDetailPK" style="display: none" />
<gw:textbox id="txtParentPK" style="display: none" />
<gw:textbox id="txtPackingTypePK" style="display: none" />
<gw:textbox id="txtPackingTypePK01" style="display: none" />
<!---------------------------------------------------------------->
</html>
