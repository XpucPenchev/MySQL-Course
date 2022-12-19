/****** Script for SelectTopNRows command from SSMS  ******/

--GO
--DECLARE @snapshot_date DATE = '2022-11-01';
--DECLARE @tds_date DATE = '2020-09-30';

CREATE PROCEDURE [dbo].[GetInferenceDataset_LOGREG]
    @snapshot_date DATE
AS
    SET NOCOUNT ON;
    SET ROWCOUNT 0;

WITH t_current_debts AS (	
	SELECT t_d.[ID]
      ,t_d.[ContactID]
	  ,t_d.[ConvertedDueNow]
      ,t_d.[StatusID]
      ,t_d.[SubStatusID]
      ,t_d.[CreditorID]
	  ,t_d.[CompanyID]
      ,t_d.[ActivePhonesCount]
	  ,t_d.[LastPaidDate]
	  ,t_d.[LPDateCession]
	  ,@snapshot_date AS snapshot_date
	  ,CASE
			WHEN t_d.[LastPaidDate] IS NOT NULL THEN t_d.[LastPaidDate]
			ELSE t_d.[LPDateCession] 
			END AS last_payment_date
	  ,t_cm.[XsiDocumentSendOnDate]
  FROM [DCA_CMS_Reports].[businessIntelligence].[vDebts] t_d
  LEFT JOIN [DCA_CMS_Reports].[businessIntelligence].[vCourtModule] t_cm
      ON t_cm.[DebtID] = t_d.[ID]),
	  t_current_client_agg AS (
	SELECT
        [ContactID],
        SUM(CASE WHEN [StatusID] = 1 THEN [ConvertedDueNow] ELSE 0 END) AS debt_current,
        MIN(CASE WHEN [StatusID] = 1 THEN [XsiDocumentSendOnDate] ELSE NULL END) AS bailiff_request_date_first,
        SUM(CASE WHEN [StatusID] = 2 THEN 1 ELSE 0 END) AS cnt_closed_cases,
		MAX(last_payment_date) AS last_payment_date_client
      FROM t_current_debts t_d
     GROUP BY [ContactID]
    )
	SELECT
        t_d.ID AS id_int,
        t_d.ContactID AS client_id,
        t_d.snapshot_date,
        t_cca.debt_current AS debt_current_client,
        t_cca.bailiff_request_date_first AS bailiff_request_date_client_first,
        t_d.[CreditorID] AS creditor,
        t_d.[ActivePhonesCount] AS cnt_phone_numbers_active,
		t_cca.last_payment_date_client,
        t_cca.cnt_closed_cases
      FROM t_current_debts t_d
      JOIN t_current_client_agg t_cca
        ON  t_d.[ContactID] = t_cca.[ContactID]
     WHERE t_d.[StatusID] = 1
       AND t_d.[SubStatusID] = 2 AND t_d.[CompanyID] IN (1,2)


	   