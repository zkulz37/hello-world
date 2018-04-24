using System;
using System.Data;
using System.Data.OracleClient;
using System.Configuration;
using System.Collections;
using System.IO;
using Excel;
using System.Diagnostics;


public partial class reports_ep_hd_ReportTemplate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {       
        string rptName;
        rptName = Request.QueryString["rptName"];

        switch (rptName)
        {
            case "epbp00010":
                CreateExcel_epbp00010();
            break;
            case "epbp00030":
                CreateExcel_epbp00030();
            break;
        }
    }

    private void RemoveFiles(string strPath)
    {
        System.IO.DirectoryInfo di = new DirectoryInfo(strPath);
        FileInfo[] fiArr = di.GetFiles();
        foreach (FileInfo fri in fiArr)
        {

            if (fri.Extension.ToString() == ".xls" )
            {
                TimeSpan min = new TimeSpan(0, 0, 60, 0, 0);
                if (fri.CreationTime < DateTime.Now.Subtract(min))
                {
                    fri.Delete();
                }
            }
        }
    }

    private void CreateExcel_epbp00010()
    {
        string strCurrentDir = Server.MapPath(".") + "\\";
        RemoveFiles(strCurrentDir); // utility method to clean up old files			
        Excel.Application oXL;
        Excel._Workbook oWB;
        Excel._Worksheet oSheet;
        Excel.Range oRng;

        try
        {
            ESysLib.SetUser("imex");
            string SQL, company = "", company_pk = "", pk="";
            System.Data.DataTable resultdata;
            resultdata = new System.Data.DataTable();
            pk = Request.QueryString["pk"];
            company_pk = Request.QueryString["company_pk"];

            SQL = " select  a.partner_name, a.addr1 ";
            SQL = SQL + " from    tco_company a  ";
            SQL = SQL + " where pk='" + company_pk + "'";

            System.Data.DataTable dt = ESysLib.TableReadOpen(SQL);

            SQL = " select distinct a.PK , a.tim_cinv_mst_a_pk, a.decl_no  ";
            SQL = SQL + "       ,to_char(to_date(a.decl_date,'YYYYMMDD'),'dd-Mon-yyy') decl_date  ";
            SQL = SQL + "       ,a.tr_ccy ,a.EX_RATE ,a.TOT_NET_TR_AMT ,a.TCO_BUSPARTNER_pk3  ";
            SQL = SQL + "       ,a.TCO_BUSPARTNER_pk4 ,e.PARTNER_id F_ID ,e.PARTNER_name F_NM  ";
            SQL = SQL + "       ,f.PARTNER_id CO_ID ,f.PARTNER_name CO_NM ,c.PARTNER_id CustID  ";
            SQL = SQL + "       ,c.PARTNER_name ,d.PARTNER_id CS_ID ,d.PARTNER_name CS_NM     ";
            SQL = SQL + "       ,a.DECL_TYPE ,b.co_invoice_no  ,a.TCO_BUSPARTNER_pk1      ";
            SQL = SQL + "       ,to_char(to_date(a.import_date,'YYYYMMDD'),'dd-Mon-yyyy') import_date ";
            SQL = SQL + "       ,decode(a.STATUS,1,'Saved',2,' Confirmed ',3,'Cancelled',0,'Approved')";
            SQL = SQL + "       ,a.ctr_type  ,a.LICENSE  ";
            SQL = SQL + "       ,to_char(to_date(a.LICENSE_DATE,'YYYYMMDD'),'dd-Mon-yyyy') LICENSE_DATE ";
            SQL = SQL + "       ,to_char(to_date(a.LICENSE_EXPDATE,'YYYYMMDD'),'dd-Mon-yyyy') LICENSE_EXPDATE  ";
            SQL = SQL + "       ,h.Contr_No  ";
            SQL = SQL + "       ,to_char(to_date(h.CONTR_DATE,'YYYYMMDD'),'dd-Mon-yyyy') CONTR_DATE  ";
            SQL = SQL + "       ,to_char(to_date(h.EXP_DATE,'YYYYMMDD'),'dd-Mon-yyyy')EXP_DATE  ";
            SQL = SQL + "       ,to_char(to_date(b.CO_INVOICE_DATE,'YYYYMMDD'),'dd-Mon-yyyy') CO_INVOICE_DATE   ";
            SQL = SQL + "       ,TRANSPORT_BY  ,i.VESSEL_FLT_NAME  ";
            SQL = SQL + "       ,to_char(to_date(i.ARRIVAL_DATE,'YYYYMMDD'),'dd-Mon-yyyy') ARRIVAL_DATE  ";
            SQL = SQL + "       ,a.TIE_BL_MST_PK ,i.BILL_NO  ";
            SQL = SQL + "       ,to_char(to_date(i.BILL_DATE,'YYYYMMDD'),'dd-Mon-yyyy')  BILL_DATE  ";
            SQL = SQL + "       ,a.ACCEPT_NO ,a.ANNEX ,a.NO_OF_DECL ,a.ENCLOSED_DOC ,a.CARTON ,a.WEIGHT ";
            SQL = SQL + "       ,a.CONT20 ,a.CONT40 ,a.DECL_TYPE ,I.TIE_COUNTRY_CD22 ,j.code_nm  ";
            SQL = SQL + "       ,I.PLACE_OF_LOADING_NM ,I.IMPORT_GATE ,m.code_nm ,a.tr_ccy   ";
            SQL = SQL + "       ,c.addr1 ||' '|| c.addr2 || ' ' ||c.addr3 cust_add  ";
            SQL = SQL + "       ,f.addr1 ||' '|| f.addr2 || ' ' ||f.addr3 ex_add  ";
            SQL = SQL + "       ,e.addr1 ||' '|| e.addr2 || ' ' ||e.addr3 l_add  ";
            SQL = SQL + "       ,l.code_nm   ";
            SQL = SQL + "       ,d.addr1 ||' '|| d.addr2 || ' ' ||d.addr3 co_add  ";
            SQL = SQL + "       ,i.PLACE_OF_LOADING, i.PLACE_OF_DISCHARGE, i.PLC_OF_DISCHARGE_NM, trans_name ";
            SQL = SQL + " from  tim_decl_mst a left join tie_bl_mst i on a.tie_bl_mst_pk=i.pk   ";
            SQL = SQL + "      left join tim_cinv_mst_a  b on a.TIM_CINV_MST_A_PK=b.pk     ";
            SQL = SQL + "      left join TCO_BUSPARTNER  c on a.TCO_BUSPARTNER_PK1 =c.pk  ";
            SQL = SQL + "      left join TCO_BUSPARTNER  d on a.TCO_BUSPARTNER_PK2 =d.pk  ";
            SQL = SQL + "      left join TCO_BUSPARTNER  e on a.TCO_BUSPARTNER_PK3 =e.pk  ";
            SQL = SQL + "      left join TCO_BUSPARTNER  f on a.TCO_BUSPARTNER_PK4 =f.pk  ";
            SQL = SQL + "      left join tim_cinv_mst_b g on g.tim_cinv_mst_a_pk=b.pk  ";
            SQL = SQL + "      left join tim_contr_mst h on g.tim_contr_mst_pk=h.pk   ";
            SQL = SQL + "      left join (select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b  ";
            SQL = SQL + "            where TCO_ABCODEGRP_PK=b.pk and b.id='COAB0080'  ";
            SQL = SQL + "                and a.del_if=0 and b.del_if=0 order by a.CODE) j on i.tie_country_cd22=j.code  ";
            SQL = SQL + "      left join (select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b ";
            SQL = SQL + "              where TCO_ABCODEGRP_PK=b.pk and b.id='ACCR0140' ";
            SQL = SQL + "                  and a.del_if=0 and b.del_if=0 order by a.CODE) l on b.PAY_METH=l.code ";
            SQL = SQL + "      left join (select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b ";
            SQL = SQL + "              where TCO_ABCODEGRP_PK=b.pk and b.id='IEAB0010' ";
            SQL = SQL + "                  and a.del_if=0 and b.del_if=0 order by a.CODE) m on upper(I.TRADE_TERMS)=upper(m.code) ";
            SQL = SQL + "    where a.del_if=0      and  a.pk ='" + pk + "'";

             resultdata = ESysLib.TableReadOpen(SQL);
            
             SQL = "  select  c.item_name, c.item_code, m.code_nm ";
             SQL = SQL + "     , to_char(a.qty,'999,999,999') qty, a.unit_cd ";
             SQL = SQL + "     , decode(e.tr_ccy,'VND',to_char(a.u_price,'999,999,999'),to_char(a.u_price,'999,999,990.99')) u_price ";
             SQL = SQL + "     , decode(e.tr_ccy,'VND',to_char(a.EXT_PRICE ,'999,999,999'),to_char(a.EXT_PRICE ,'999,999,990.99')) ext_amt  ";
             SQL = SQL + "     , decode(e.tr_ccy,'VND',to_char(nvl(IM_TAX_CALC_AMT,0)+ nvl(RE_IM_TAX_CALC_AMT,0),'999,999,999'),to_char(nvl(IM_TAX_CALC_AMT,0)+ nvl(RE_IM_TAX_CALC_AMT,0),'999,999,990.99')) tr_amt  ";
             SQL = SQL + "     , to_char(a.IM_TAX_RATE,'999,999,999.99') im_tax_rate ";
             SQL = SQL + "     , decode(e.tr_ccy,'VND',to_char(a.IM_TAX_AMT,'999,999,999'),to_char(a.IM_TAX_AMT,'999,999,990.99')) tax_amt  ";
             SQL = SQL + "     , decode(e.tr_ccy,'VND',to_char(a.VAT_AMT,'999,999,999'),to_char(a.VAT_AMT,'999,999,990.99')) vat_tr_amt ";
             SQL = SQL + "     , to_char(a.VAT_RATE,'999,999,999.99') vat_tax_rate ";
             SQL = SQL + "     , decode(e.tr_ccy,'VND',to_char(nvl(a.VAT_AMT,0)*nvl(a.VAT_RATE,0)/100,'999,999,999'),to_char(nvl(a.VAT_AMT,0)*nvl(a.VAT_RATE,0)/100,'999,999,990.99')) vat_amt ";
             SQL = SQL + "     , to_char(a.OT_TAX_RATE,'999,999,999.99') ot_tax_rate ";
             SQL = SQL + "     , decode(e.tr_ccy,'VND',to_char(nvl(a.OT_TAX_CALC_AMT,0)*nvl(a.OT_TAX_RATE,0)/100,'999,999,999'),to_char(nvl(a.OT_TAX_CALC_AMT,0)*nvl(a.OT_TAX_RATE,0)/100,'999,999,990.99')) vat_amt ";
             SQL = SQL + " from tim_decl_dtl a   ";
             SQL = SQL + "    left join tco_item c on a.tco_item_pk = c.pk  ";
             SQL = SQL + "    left join tim_decl_mst e on a.tim_decl_mst_pk=e.pk  ";
             SQL = SQL + "    left join (select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b  ";
             SQL = SQL + "                where TCO_ABCODEGRP_PK=b.pk and b.id='COAB0080'  ";
             SQL = SQL + "                    and a.del_if=0 and b.del_if=0 order by a.CODE) m on item_origin=m.code ";
             SQL = SQL + " where a.del_if = 0  ";
             SQL = SQL + "    and a.tim_decl_mst_pk='" + pk + "'";

             System.Data.DataTable dtItem = ESysLib.TableReadOpen(SQL);
             
            GC.Collect();// clean up any other excel guys hangin' around...            
            oXL = new Excel.Application();            
            oXL.Visible = true   ;
            //Get a new workbook.
            oWB = (Excel._Workbook)(oXL.Workbooks.Add(strCurrentDir +  "rpt_ephd00010_decl.xlt"));
            oSheet = (Excel._Worksheet)oWB.Sheets["ToKhai"];

            if (dt.Rows.Count > 0)
            {
                oSheet.Cells[10, 2] = dt.Rows[0][0];
                oSheet.Cells[11, 2] = dt.Rows[0][1];
            }

            // Create Header and sheet...
            if (resultdata.Rows.Count > 0)
            {
                oSheet.Cells[5, 4] = resultdata.Rows[0][12];
                oSheet.Cells[4, 12] = resultdata.Rows[0][2];
                oSheet.Cells[5, 12] = resultdata.Rows[0][3];
                Range r = (Range)oSheet.Cells[6,10];
                oSheet.Cells[6,10] = (string) r.Text + " " + resultdata.Rows[0][37];
                oSheet.Cells[10,12] = resultdata.Rows[0][23];
                oSheet.Cells[10,14] = resultdata.Rows[0][26];
                oSheet.Cells[11,9] = resultdata.Rows[0][44];
                oSheet.Cells[11,12] = resultdata.Rows[0][24];
                oSheet.Cells[11,14] = resultdata.Rows[0][27];
                oSheet.Cells[12,12] = resultdata.Rows[0][25];
                oSheet.Cells[12,14] = resultdata.Rows[0][28];
                oSheet.Cells[14, 2] = resultdata.Rows[0][14];
                r = (Range)oSheet.Cells[14, 9];
                oSheet.Cells[14, 9] = (string) r.Text + " "  + resultdata.Rows[0][18];
                r = (Range)oSheet.Cells[14, 11];
                oSheet.Cells[14, 11] = (string) r.Text + " " + resultdata.Rows[0][31];
                oSheet.Cells[14, 15] = resultdata.Rows[0][34];
                oSheet.Cells[15, 2] = resultdata.Rows[0][51];
                r = (Range)oSheet.Cells[15,9];
                oSheet.Cells[15, 9] = (string)r.Text + " " + resultdata.Rows[0][29];
                r = (Range)oSheet.Cells[15, 11];
                oSheet.Cells[15, 11] = (string)r.Text + " " + resultdata.Rows[0][59];
                oSheet.Cells[16, 12] = resultdata.Rows[0][32];
                oSheet.Cells[16, 15] = resultdata.Rows[0][35];
                oSheet.Cells[18, 2] = resultdata.Rows[0][16];
                oSheet.Cells[18, 9] = resultdata.Rows[0][46];
                oSheet.Cells[18, 11] = resultdata.Rows[0][56];
                oSheet.Cells[18, 14] = resultdata.Rows[0][57];
                oSheet.Cells[19, 2] = resultdata.Rows[0][55];
                oSheet.Cells[19, 9] = resultdata.Rows[0][45];
                oSheet.Cells[19, 11] = resultdata.Rows[0][47];
                oSheet.Cells[19, 14] = resultdata.Rows[0][58];
                oSheet.Cells[21, 2] = resultdata.Rows[0][10];
                oSheet.Cells[21, 9] = resultdata.Rows[0][49];
                oSheet.Cells[22, 12] = resultdata.Rows[0][5];
                r = (Range)oSheet.Cells[20, 11];
                oSheet.Cells[20, 11] = (string)r.Text + resultdata.Rows[0][4];
                oSheet.Cells[19, 11] = resultdata.Rows[0][47];
                oSheet.Cells[21, 14] = resultdata.Rows[0][54];
            }

            int iRow, iCol;
            iRow = 25;
            if (dtItem.Rows.Count > 0 && dtItem.Rows.Count <= 3)
            {
                for (int i = 0; i < dtItem.Rows.Count; i++)
                {
                    // Gia tri
                    iRow = 25 + i;
                    oSheet.Cells[iRow, 3] = dtItem.Rows[0][0];
                    oSheet.Cells[iRow, 7] = dtItem.Rows[0][1];
                    oSheet.Cells[iRow, 9] = dtItem.Rows[0][2];
                    oSheet.Cells[iRow, 10] = dtItem.Rows[0][3];
                    oSheet.Cells[iRow, 11] = dtItem.Rows[0][4];
                    oSheet.Cells[iRow, 12] = dtItem.Rows[0][5];
                    oSheet.Cells[iRow, 14] = dtItem.Rows[0][6];

                    //Thue
                    iRow = 32 + i;
                    oSheet.Cells[iRow, 3] = dtItem.Rows[0][7];
                    oSheet.Cells[iRow, 7] = dtItem.Rows[0][8];
                    oSheet.Cells[iRow, 9] = dtItem.Rows[0][9];
                    oSheet.Cells[iRow, 10] = dtItem.Rows[0][10];
                    oSheet.Cells[iRow, 11] = dtItem.Rows[0][11];
                    oSheet.Cells[iRow, 12] = dtItem.Rows[0][12];
                    oSheet.Cells[iRow, 14] = dtItem.Rows[0][13];
                    oSheet.Cells[iRow, 15] = dtItem.Rows[0][14];
                }
            }
            else
            {
                if (dtItem.Rows.Count > 3)
                {
                    oSheet = (Excel._Worksheet)oWB.Sheets["PhuLuc"];
                    for (int i = 0; i < dtItem.Rows.Count; i++)
                    {
                        // Gia tri
                        iRow = 9 + i; 		

                        oSheet.Cells[iRow, 2] = dtItem.Rows[0][0];
                        oSheet.Cells[iRow, 10] = dtItem.Rows[0][1];
                        oSheet.Cells[iRow, 14] = dtItem.Rows[0][2];
                        oSheet.Cells[iRow, 17] = dtItem.Rows[0][3];
                        oSheet.Cells[iRow, 21] = dtItem.Rows[0][4];
                        oSheet.Cells[iRow, 24] = dtItem.Rows[0][5];
                        oSheet.Cells[iRow, 28] = dtItem.Rows[0][6];

                        //Thue
                        iRow = 22 + i; 								

                        oSheet.Cells[iRow, 2] = dtItem.Rows[0][7];
                        oSheet.Cells[iRow, 7] = dtItem.Rows[0][8];
                        oSheet.Cells[iRow, 9] = dtItem.Rows[0][9];
                        oSheet.Cells[iRow, 14] = dtItem.Rows[0][10];
                        oSheet.Cells[iRow, 19] = dtItem.Rows[0][11];
                        oSheet.Cells[iRow, 21] = dtItem.Rows[0][12];
                        oSheet.Cells[iRow, 26] = dtItem.Rows[0][13];
                        oSheet.Cells[iRow, 28] = dtItem.Rows[0][14];
                    }
                }
            }

            //Format A1:Z1 as bold, vertical alignment = center.
            //oSheet.get_Range("A1", "Z1").Font.Bold = true;
            //oSheet.get_Range("A1", "Z1").VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;
            //AutoFit columns A:Z.
            oRng = oSheet.get_Range("A1", "Z1");
           
            oXL.Visible = true   ;
            oXL.UserControl = false;
            string strFile = "rpt_ephd00010_" + System.DateTime.Now.Ticks.ToString() + ".xls";
            oWB.SaveAs(strCurrentDir + strFile, Excel.XlFileFormat.xlWorkbookNormal, null, null, false, false, Excel.XlSaveAsAccessMode.xlShared, false, false, null, null, null);
            // Need all following code to clean up and extingush all references!!!
            oWB.Close(null, null, null);
            oXL.Workbooks.Close();
            oXL.Quit();
            System.Runtime.InteropServices.Marshal.ReleaseComObject(oRng);
            System.Runtime.InteropServices.Marshal.ReleaseComObject(oXL);
            System.Runtime.InteropServices.Marshal.ReleaseComObject(oSheet);
            System.Runtime.InteropServices.Marshal.ReleaseComObject(oWB);
            oSheet = null;
            oWB = null;
            oXL = null;
            GC.Collect();  // force final cleanup!
            //string strMachineName = Request.ServerVariables["SERVER_NAME"];
           // Response.Write("<A href=http://" + strMachineName + "/esys/" + strCurrentDir + strFile + ">Download Report</a>");
            //string strURL = "../hd/" + strFile;
            //string strPopup = "<script language='javascript'>" + " window.open('" + strURL + "','window" +
            //              "','width=800,height=600,menubar=yes,resizable=yes'); window.focus(); </script>";

            //Page.RegisterClientScriptBlock("Pop", strPopup);
            Response.Write(strFile);
        }
        catch (Exception theException)
        {
            String errorMessage;
            errorMessage = "Error: ";
            errorMessage = String.Concat(errorMessage, theException.Message);
            errorMessage = String.Concat(errorMessage, " Line: ");
            errorMessage = String.Concat(errorMessage, theException.Source);
            Response.Write( errorMessage);
        }
    }

    private void CreateExcel_epbp00030()
    {
        string strCurrentDir = Server.MapPath(".") + "\\";
        RemoveFiles(strCurrentDir); // utility method to clean up old files			
        Excel.Application oXL;
        Excel._Workbook oWB;
        Excel._Worksheet oSheet;
        Excel.Range oRng;

        try
        {
            ESysLib.SetUser("imex");
            string SQL, company = "", company_pk = "", pk = "";
            System.Data.DataTable resultdata;
            resultdata = new System.Data.DataTable();
            pk = Request.QueryString["pk"];
            company_pk = Request.QueryString["company_pk"];

            SQL = " select  a.partner_name, a.addr1 ";
            SQL = SQL + " from    tco_company a  ";
            SQL = SQL + " where pk='" + company_pk + "'";

            System.Data.DataTable dt = ESysLib.TableReadOpen(SQL);

            SQL = "select distinct  a.decl_no   " +
                "       ,to_char(to_date(a.decl_date,'YYYYMMDD'),'dd/MM/yyyy') decl_date   " +
                "       ,a.tr_ccy ,a.EX_RATE ,a.TOT_NET_TR_AMT   " +
                "       ,e.PARTNER_id F_ID ,e.PARTNER_name F_NM   " +
                "       ,f.PARTNER_id CO_ID ,f.PARTNER_name CO_NM ,c.PARTNER_id CustID   " +
                "       ,c.PARTNER_name ,d.PARTNER_id CS_ID ,d.PARTNER_name CS_NM      " +
                "       ,a.DECL_TYPE ,b.co_invoice_no  , p.PARTNER_NAME cust_name, a.ANNEX       " +
                "       ,to_char(to_date(a.export_date,'YYYYMMDD'),'dd.MM.yyyy') export_date  " +
                "       , m.code_nm " +
                "       ,a.ctr_type  ,a.LICENSE   " +
                "       ,to_char(to_date(a.LICENSE_DATE,'YYYYMMDD'),'dd.MM.yyyy') LICENSE_DATE  " +
                "       ,to_char(to_date(a.LICENSE_EXPDATE,'YYYYMMDD'),'dd.MM.yyyy') LICENSE_EXPDATE   " +
                "       ,h.Contr_No   " +
                "       ,to_char(to_date(h.CONTR_DATE,'YYYYMMDD'),'dd.MM.yyyy') CONTR_DATE   " +
                "       ,to_char(to_date(h.EXP_DATE,'YYYYMMDD'),'dd.MM.yyyy')EXP_DATE " +
                "       ,IM_PORT_COUNTRY, j.code_nm	,EXPORT_GATE, i.code_nm	 " +
                "       ,c.addr1 ||' '|| c.addr2 || ' ' ||c.addr3 cust_add   " +
                "       ,f.addr1 ||' '|| f.addr2 || ' ' ||f.addr3 ex_add   " +
                "       ,e.addr1 ||' '|| e.addr2 || ' ' ||e.addr3 l_add   " +
                "       ,l.code_nm    " +
                "       ,d.addr1 ||' '|| d.addr2 || ' ' ||d.addr3 co_add   " +
                " from  tex_decl_mst a    " +
                "      left join tex_cinv_mst_a  b on a.Tex_CINV_MST_A_PK=b.pk      " +
                "      left join TCO_BUSPARTNER  c on a.TCO_BUSPARTNER_PK1 =c.pk   " +
                "      left join TCO_BUSPARTNER  d on a.TCO_BUSPARTNER_PK2 =d.pk   " +
                "      left join TCO_BUSPARTNER  e on a.TCO_BUSPARTNER_PK3 =e.pk   " +
                "      left join TCO_BUSPARTNER  f on a.TCO_BUSPARTNER_PK4 =f.pk   " +
                "      left join TCO_BUSPARTNER  p on a.TCO_BUSPARTNER_PK  =p.pk   " +
                "      left join tex_cinv_mst_b g on g.tex_cinv_mst_a_pk=b.pk   " +
                "      left join tex_contr_mst h on g.tex_contr_mst_pk=h.pk    " +
                "      left join (select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b   " +
                "            where TCO_ABCODEGRP_PK=b.pk and b.id='COAB0080'   " +
                "                and a.del_if=0 and b.del_if=0 order by a.CODE) j on a.IM_PORT_COUNTRY=j.code  " +
                "      left join (select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b   " +
                "            where TCO_ABCODEGRP_PK=b.pk and b.id='COAB0080'   " +
                "                and a.del_if=0 and b.del_if=0 order by a.CODE) i on a.EXPORT_GATE=i.code  " +
                "      left join (select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b  " +
                "              where TCO_ABCODEGRP_PK=b.pk and b.id='ACCR0140'  " +
                "                  and a.del_if=0 and b.del_if=0 order by a.CODE) l on b.PAY_METH=l.code  " +
                "      left join (select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b  " +
                "              where TCO_ABCODEGRP_PK=b.pk and b.id='IEAB0010'  " +
                "                  and a.del_if=0 and b.del_if=0 order by a.CODE) m on upper(b.TRADE_TERMS)=upper(m.code)  " +
                "    where a.del_if=0   and  a.pk ='" + pk + "'";

            resultdata = ESysLib.TableReadOpen(SQL);

            SQL = "select  c.item_name, c.item_code " +
                "     , to_char(a.qty,'999,999,999') qty, a.unit_cd  " +
                "     , decode(e.tr_ccy,'VND',to_char(a.u_price,'999,999,999'),to_char(a.u_price,'999,999,990.99')) u_price  " +
                "     , decode(e.tr_ccy,'VND',to_char(a.EXT_PRICE ,'999,999,999'),to_char(a.EXT_PRICE ,'999,999,990.99')) ext_amt " +
                " from tex_decl_dtl a    " +
                "    left join tco_item c on a.tco_item_pk = c.pk   " +
                "    left join tex_decl_mst e on a.tex_decl_mst_pk=e.pk " +
                " where a.del_if = 0  " +
                "    and a.tex_decl_mst_pk='" + pk + "'";

            System.Data.DataTable dtItem = ESysLib.TableReadOpen(SQL);

            GC.Collect();// clean up any other excel guys hangin' around...            
            oXL = new Excel.Application();
            oXL.Visible = true;
            //Get a new workbook.
            oWB = (Excel._Workbook)(oXL.Workbooks.Add(strCurrentDir + "rpt_ephd00030_decl.xlt"));
            oSheet = (Excel._Worksheet)oWB.Sheets["ToKhai"];

            if (dt.Rows.Count > 0)
            {
                oSheet.Cells[10, 2] = dt.Rows[0][0];
                oSheet.Cells[11, 2] = dt.Rows[0][1];
            }

            // Create Header and sheet...
            if (resultdata.Rows.Count > 0)
            {
                oSheet.Cells[4, 4] = resultdata.Rows[0][15];
                oSheet.Cells[3, 12] = resultdata.Rows[0][0];
                oSheet.Cells[4, 12] = resultdata.Rows[0][1];
                oSheet.Cells[5, 12] = resultdata.Rows[0][16];
                oSheet.Cells[9, 2] = resultdata.Rows[0][10];
                oSheet.Cells[9, 14] = resultdata.Rows[0][20];
                oSheet.Cells[10, 2] = resultdata.Rows[0][30];
                oSheet.Cells[10, 9] = resultdata.Rows[0][13];
                oSheet.Cells[10, 14] = resultdata.Rows[0][21];
                oSheet.Cells[11, 14] = resultdata.Rows[0][22];
                oSheet.Cells[13, 2] = resultdata.Rows[0][12];
                oSheet.Cells[13, 11] = resultdata.Rows[0][23];
                oSheet.Cells[14, 2] = resultdata.Rows[0][32];
                oSheet.Cells[14, 11] = resultdata.Rows[0][24];
                oSheet.Cells[14, 12] = resultdata.Rows[0][27];
                oSheet.Cells[15, 11] = resultdata.Rows[0][25];
                oSheet.Cells[15, 12] = resultdata.Rows[0][26];
                oSheet.Cells[17, 2] = resultdata.Rows[0][6];
                oSheet.Cells[15, 11] = resultdata.Rows[0][25];
                oSheet.Cells[15, 12] = resultdata.Rows[0][26];
                oSheet.Cells[17, 2] = resultdata.Rows[0][6];
                oSheet.Cells[17, 9] = resultdata.Rows[0][29];
                oSheet.Cells[17, 12] = resultdata.Rows[0][18];
                oSheet.Cells[18, 2] = resultdata.Rows[0][30];
                oSheet.Cells[18, 9] = resultdata.Rows[0][28];
                oSheet.Cells[19, 11] = resultdata.Rows[0][2];
                oSheet.Cells[20, 11] = resultdata.Rows[0][3];
                oSheet.Cells[21, 2] = resultdata.Rows[0][31];
                oSheet.Cells[20, 12] = resultdata.Rows[0][33];
                oSheet.Cells[32, 14] = resultdata.Rows[0][4];  
            }

            int iRow, iCol;
            iRow = 23;
            if (dtItem.Rows.Count > 0 && dtItem.Rows.Count <= 8)
            {
                for (int i = 0; i < dtItem.Rows.Count; i++)
                {
                    // Gia tri
                    iRow = 23 + i; 

                    oSheet.Cells[iRow, 3] = dtItem.Rows[0][0];
                    oSheet.Cells[iRow, 6] = dtItem.Rows[0][1];
                    oSheet.Cells[iRow, 9] = dtItem.Rows[0][2];
                    oSheet.Cells[iRow, 11] = dtItem.Rows[0][3];
                    oSheet.Cells[iRow, 12] = dtItem.Rows[0][4];
                    oSheet.Cells[iRow, 14] = dtItem.Rows[0][5];                  
                }
            }
            else
            {
                if (dtItem.Rows.Count > 8)
                {
                    oSheet = (Excel._Worksheet)oWB.Sheets["PhuLuc"];
                    for (int i = 0; i < dtItem.Rows.Count; i++)
                    {
                        // Gia tri
                        iRow = 9 + i;

                        oSheet.Cells[iRow, 2] = dtItem.Rows[0][0];
                        oSheet.Cells[iRow, 12] = dtItem.Rows[0][1];
                        oSheet.Cells[iRow, 17] = dtItem.Rows[0][2];
                        oSheet.Cells[iRow, 21] = dtItem.Rows[0][3];
                        oSheet.Cells[iRow, 25] = dtItem.Rows[0][4];
                        oSheet.Cells[iRow, 29] = dtItem.Rows[0][5];                                                     
                    }
                    oSheet.Cells[32, 29] = resultdata.Rows[0][4];
                }

            }

            //Format A1:Z1 as bold, vertical alignment = center.
            //oSheet.get_Range("A1", "Z1").Font.Bold = true;
            //oSheet.get_Range("A1", "Z1").VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;
            //AutoFit columns A:Z.
            oRng = oSheet.get_Range("A1", "Z1");

            oXL.Visible = true;
            oXL.UserControl = false;
            string strFile = "rpt_ephd00030_" + System.DateTime.Now.Ticks.ToString() + ".xls";
            oWB.SaveAs(strCurrentDir + strFile, Excel.XlFileFormat.xlWorkbookNormal, null, null, false, false, Excel.XlSaveAsAccessMode.xlShared, false, false, null, null, null);
            // Need all following code to clean up and extingush all references!!!
            oWB.Close(null, null, null);
            oXL.Workbooks.Close();
            oXL.Quit();
            System.Runtime.InteropServices.Marshal.ReleaseComObject(oRng);
            System.Runtime.InteropServices.Marshal.ReleaseComObject(oXL);
            System.Runtime.InteropServices.Marshal.ReleaseComObject(oSheet);
            System.Runtime.InteropServices.Marshal.ReleaseComObject(oWB);
            oSheet = null;
            oWB = null;
            oXL = null;
            GC.Collect();  // force final cleanup!
            //string strMachineName = Request.ServerVariables["SERVER_NAME"];
            // Response.Write("<A href=http://" + strMachineName + "/esys/" + strCurrentDir + strFile + ">Download Report</a>");
            //string strURL = "../hd/" + strFile;
            //string strPopup = "<script language='javascript'>" + " window.open('" + strURL + "','window" +
            //              "','width=800,height=600,menubar=yes,resizable=yes'); window.focus(); </script>";

            //Page.RegisterClientScriptBlock("Pop", strPopup);
            Response.Write(strFile);
        }
        catch (Exception theException)
        {
            String errorMessage;
            errorMessage = "Error: ";
            errorMessage = String.Concat(errorMessage, theException.Message);
            errorMessage = String.Concat(errorMessage, " Line: ");
            errorMessage = String.Concat(errorMessage, theException.Source);
            Response.Write(errorMessage);
        }
    }
}
