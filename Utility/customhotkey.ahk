;   Databases
::revweb::RevWebAdmin.dbo.
::revt::ReventionTest.dbo.
::gmap::gmap
::pos-temp::pos-template


;	SQL
::ssf::SELECT *{ENTER}FROM
::stf::SELECT TOP 10 *{ENTER}FROM
::trt::TRUNCATE TABLE 
::ssfsp::SELECT '[' {+} SCHEMA_NAME(schema_id) {+} '.' {+} name {+} ']' AS ObjectName, * FROM sys.procedures WHERE name LIKE '%%' ORDER BY name {Left 17}
::ssfso::SELECT '[' {+} SCHEMA_NAME(schema_id) {+} '.' {+} name {+} ']' AS ObjectName, * FROM sys.objects WHERE name LIKE '%%' ORDER BY name {Left 17}
::ssp::SELECT '[' {+} SCHEMA_NAME(schema_id) {+} '.' {+} name {+} ']' AS ObjectName, * FROM sys.procedures WHERE OBJECT_DEFINITION(object_id) LIKE '%%' ORDER BY name {Left 17}
::ij::INNER JOIN
::lj::LEFT JOIN
::gb::GROUP BY
::ob::ORDER BY
::ob1::ORDER BY 1 DESC
::nl::WITH (NOLOCK)
::rl::WITH (ROWLOCK)
::wh::WHERE
::dt::DATETIME
::vc::VARCHAR
::ROWNUM::[RowNumber]=ROW_NUMBER() OVER(PARTITION BY Field1 ORDER BY Field1 DESC)
::tblcol::SELECT COLUMN_NAME AS 'ColumnName', TABLE_NAME AS  'TableName' FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME LIKE '%MyName%' ORDER BY TableName, ColumnName; {Left 35}

;   Frequently used tables
::synct::SyncTables
::synctl::SyncTablesLog
::sto::Stores

;  CSOD
;::D::DUPE{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}{SPACE}{TAB}{TAB}{SPACE}{ENTER}

;separtion line
::sep::-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

;git commands
::gu::git remote update
::gp::git pull
::gl::git log --oneline --decorate --graph
::gbl::git branch --list
::gbd::git branch -D users/kaushik/
::gstat::git status
::gc::git checkout
::gcb::git checkout -b
::gf::git fetch --prune
::gcred::git config --global credential.helper store
::gunsetglobal::git config --global --unset credential.helper
::gunsetsys::git config --system --unset credential.helper
::gorigin::git remote show origin

;find table relationships
::tblrel::SELECT {Enter}fk.name 'FK Name', {Enter}tp.name 'Parent table', {Enter}cp.name, cp.column_id, {Enter}tr.name 'Refrenced table', {Enter}cr.name, cr.column_id {Enter}FROM {Enter}sys.foreign_keys fk {Enter}INNER JOIN {Enter}sys.tables tp ON fk.parent_object_id = tp.object_id {Enter}INNER JOIN  {Enter}sys.tables tr ON fk.referenced_object_id = tr.object_id {Enter}INNER JOIN  {Enter}sys.foreign_key_columns fkc ON fkc.constraint_object_id = fk.object_id {Enter}INNER JOIN  {Enter}sys.columns cp ON fkc.parent_column_id = cp.column_id AND fkc.parent_object_id = cp.object_id {Enter}INNER JOIN  {Enter}sys.columns cr ON fkc.referenced_column_id = cr.column_id AND fkc.referenced_object_id = cr.object_id {Enter}ORDER BY {Enter}tp.name, cp.column_id

;angular commands
::ngc::ng generate component 
::ngm::ng generate module 
::ngs::ng generate service 
::ngp::ng generate pipe 
::ngcfd:: ng generate component --flat --dry-run 
::ngd::ng generate directive
::ngn::ng generate module
::ngp::ng generate pipe 
::ngi::ng generate interface
::ngcl:: ng generate class

;npm commands
::npms::npm start
::npmb::npm run build
::npmd::npm run dev 
