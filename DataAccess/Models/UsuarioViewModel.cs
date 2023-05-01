using DataAccess.Utils;

namespace DataAccess.Models
{
    public class UsuarioViewModel : PadraoViewModel
    {
        public string Name_user { get; set; }
        public string Password { get; set; }
        public EnumTipoUsuario User_type { get; set; }
        public EnumFlagAtivo Flag_ativo { get; set; }
    }
}

//CREATE TABLE Usuarios
//(
//	 Id				INT PRIMARY KEY IDENTITY(1,1) NOT NULL
//	, name_user		VARCHAR(50) UNIQUE NOT NULL			-- Não pode haver repetição de nome de usuário
//	, hash_password	VARBINARY(64) NOT NULL				-- Armazena a senha criptografada em formato HASH
//	, salt_password	UNIQUEIDENTIFIER NOT NULL			-- SALT usado para validar a senha do usuário
//	, user_type		BIT NOT NULL						-- 0 cliente | 1 adm
//	, flag_ativo		BIT NOT NULL						-- 0 Inativo | 1 ativo
//)