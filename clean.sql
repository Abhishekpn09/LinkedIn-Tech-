SELECT DISTINCT designation FROM raw;

SELECT DISTINCT location from raw;

SELECT DISTINCT Level from raw;

SELECT * FROm raw;


UPDATE raw SET designation = 'Dot net Developer' WHERE designation='Dot net Developer / Sr. Developer';
UPDATE raw SET designation = 'Dotnet Developer' WHERE designation='Dot net Developer / Sr. Developer';
UPDATE raw SET designation = 'Analyst Consultant_Private Equity' WHERE designation='Analyst Consultant (Private Equity)';
UPDATE raw SET designation = 'Java Developer' WHERE designation='Java Developers';
UPDATE raw SET designation = 'Java Developer' WHERE designation='';
UPDATE raw SET designation = 'Java Developer' WHERE designation='';
UPDATE raw SET designation = 'Java Full Stack Developer' WHERE designation='''Java Full stack Developer''';
UPDATE raw SET designation = 'Java-Back end Developer' WHERE designation='Java Back-end Developer';
UPDATE raw SET designation = 'Java-Back end Developer' WHERE designation='Java Backend';
UPDATE raw SET designation = 'Project Manager' WHERE designation='Project Manager- Jaipur';
UPDATE raw SET designation = 'UI/UX Designer' WHERE designation='UI UX Designer';
UPDATE raw SET designation = 'UI/UX developer' WHERE designation='Ui Ux Developer - Mumbai';

TRUNCATE Table Designations;





