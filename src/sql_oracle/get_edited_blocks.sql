-- for reference
-- this is the core of a view v_boro_block_something_or_other
-- defined in the legacy application
-- sloppy distincts and unions, not worth untangling
select distinct boro_block from 
    (SELECT DISTINCT
            SUBSTR (a.bbl, 1, 6) AS boro_block,
            w.change_date AS change_date
        FROM dab_air_rights a, dab_wizard_transaction w
        WHERE a.trans_num = w.trans_num
    UNION
    SELECT DISTINCT
            SUBSTR (t.bbl, 1, 6) AS boro_block,
            w.change_date AS change_date
        FROM dab_boundary_line b,
            dab_wizard_transaction w,
            dab_tax_lots t
        WHERE b.trans_num = w.trans_num AND b.trans_num = t.trans_num
    UNION
    SELECT DISTINCT
            SUBSTR (c.bbl, 1, 6) AS boro_block,
            w.change_date AS change_date
        FROM dab_condo_conversion c, dab_wizard_transaction w
        WHERE c.trans_num = w.trans_num
    UNION
    SELECT DISTINCT
            SUBSTR (c.bbl, 1, 6) AS boro_block,
            w.change_date AS change_date
        FROM dab_condo_units c, dab_wizard_transaction w
        WHERE c.trans_num = w.trans_num
    UNION
    SELECT DISTINCT
            SUBSTR (r.bbl, 1, 6) AS boro_block,
            w.change_date AS change_date
        FROM dab_reuc r, dab_wizard_transaction w
        WHERE r.trans_num = w.trans_num
    UNION
    SELECT DISTINCT
            SUBSTR (s.bbl, 1, 6) AS boro_block,
            w.change_date AS change_date
        FROM dab_subterranean_rights s, dab_wizard_transaction w
        WHERE s.trans_num = w.trans_num
    UNION
    SELECT DISTINCT
            SUBSTR (t.bbl, 1, 6) AS boro_block,
            w.change_date AS change_date
        FROM dab_tax_lots t, dab_wizard_transaction w
        WHERE t.trans_num = w.trans_num)
where change_date > (current_date - 7) --DAYS HERE