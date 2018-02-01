INSERT INTO events.aspnetuserroles
	SELECT Id, 'b9a28ee9-d367-4d96-bf3e-51fc121dc4e2' FROM events.aspnetusers
		WHERE Id <> '1748e932-04f4-449a-b677-25681d63120a';