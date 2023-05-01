using DataAccess.Models;
using DataAccess.Utils;
using System;
using System.Data;
using System.Data.SqlClient;

namespace DataAccess.DAO
{
    public class ClienteDAO : PadraoDAO<ClienteViewModel>
    {
        protected GeneroDAO GeneroDAO { get; set; } = new GeneroDAO();
        protected SexoDAO SexoDAO { get; set; } = new SexoDAO();
        protected UsuarioDAO UsuarioDAO { get; set; } = new UsuarioDAO();

        protected override SqlParameter[] CriaParametros(ClienteViewModel model)
        {
            var p = new SqlParameter[]
            {
                new SqlParameter(nameof(model.Id), HelperDAO.NullAsDbNull(model.Id)),
                new SqlParameter(nameof(model.Rfid_id), model.Rfid_id),
                new SqlParameter("Usuario_Id", model.Usuario.Id),
                new SqlParameter("Genero_Id", model.Genero.Id),
                new SqlParameter("Sexo_Id", model.Sexo.Id),
                new SqlParameter(nameof(model.Nome), model.Nome),
                new SqlParameter(nameof(model.Cpf), model.Cpf),
                new SqlParameter(nameof(model.Email), HelperDAO.NullAsDbNull(model.Email)),
                new SqlParameter(nameof(model.Telefone), HelperDAO.NullAsDbNull(model.Telefone)),
                new SqlParameter(nameof(model.Endereco), HelperDAO.NullAsDbNull(model.Endereco)),
                new SqlParameter(nameof(model.Data_nascimento), model.Data_nascimento),
                new SqlParameter(nameof(model.Saldo), model.Saldo),
            };

            return p;
        }

        protected override ClienteViewModel MontaModel(DataRow registro)
        {
            var retorno = new ClienteViewModel();
            retorno.Id = Convert.ToInt32(registro[nameof(retorno.Id)]);
            retorno.Rfid_id = registro[nameof(retorno.Rfid_id)].ToString();
            retorno.Usuario = UsuarioDAO.Consulta(Convert.ToInt32(registro["Usuario_Id"]));
            retorno.Genero = GeneroDAO.Consulta(Convert.ToInt32(registro["Genero_Id"]));
            retorno.Sexo = SexoDAO.Consulta(Convert.ToInt32(registro["Sexo_Id"]));
            retorno.Nome = registro[nameof(retorno.Nome)].ToString();
            retorno.Cpf = registro[nameof(retorno.Cpf)].ToString();
            retorno.Email = HelperDAO.DbNullAsString(registro[nameof(retorno.Email)]);
            retorno.Telefone = HelperDAO.DbNullAsString(registro[nameof(retorno.Telefone)]);
            retorno.Endereco = HelperDAO.DbNullAsString(registro[nameof(retorno.Endereco)]);
            retorno.Data_nascimento = Convert.ToDateTime(registro[nameof(retorno.Data_nascimento)]);
            retorno.Saldo = Convert.ToDouble(registro[nameof(retorno.Saldo)]);

            return retorno;
        }

        protected override void SetTabela()
        {
            Tabela = EnumTabela.Clientes;
        }
    }
}
