using DataAccess.Models;
using DataAccess.Utils;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace DataAccess.DAO
{
    public class UsuarioDAO : PadraoDAO<UsuarioViewModel>
    {
        protected override SqlParameter[] CriaParametros(UsuarioViewModel model)
        {
            var p = new SqlParameter[]
            {
                new SqlParameter(nameof(model.Id), HelperDAO.NullAsDbNull(model.Id)),
                new SqlParameter(nameof(model.Name_user), model.Name_user),
                new SqlParameter(nameof(model.Password), model.Password),
                new SqlParameter(nameof(model.User_type), Convert.ToByte(model.User_type)),
                new SqlParameter(nameof(model.Flag_ativo), Convert.ToByte(model.Flag_ativo)),
            };

            return p;
        }

        protected override UsuarioViewModel MontaModel(DataRow registro)
        {
            var retorno = new UsuarioViewModel();
            retorno.Id = Convert.ToInt32(registro[nameof(retorno.Id)]);
            retorno.Name_user = registro[nameof(retorno.Name_user)].ToString();

            // Não precisa saber a senha (teoricamente)
            
            retorno.User_type = (EnumTipoUsuario) Convert.ToByte(registro[nameof(retorno.User_type)]);
            retorno.Flag_ativo = (EnumFlagAtivo) Convert.ToByte(registro[nameof(retorno.Flag_ativo)]);
            return retorno;
        }

        public virtual EnumValidaUsuario ValidaUsuario(UsuarioViewModel usuario)
        {
            SqlParameter[] p = new SqlParameter[]
            {
                new SqlParameter(nameof(usuario.Name_user), usuario.Name_user),
                new SqlParameter(nameof(usuario.Password), usuario.Password)
            };
            var tabela = HelperDAO.ExecutaProcSelect("spPesquisa_Usuarios", p);

            if (tabela.Rows.Count == 0)
                return EnumValidaUsuario.SenhaIncorreta;

            if (tabela.Rows[0][nameof(usuario.Name_user)] == DBNull.Value)
                return EnumValidaUsuario.UsuarioInvalido;

            return EnumValidaUsuario.SenhaCorreta;
        }


        protected override void SetTabela()
        {
            Tabela = EnumTabela.Usuarios;
        }
    }
}
