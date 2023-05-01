using System;

namespace DataAccess.Models
{
    /// <summary>
    /// Classe usada pelas ViewModels com chave estrageira. Precisa informar qual o tipo de dado foreign
    /// </summary>
    /// <typeparam name="U"></typeparam>
    public class PadraoForeignViewModel<U> : PadraoViewModel where U : PadraoViewModel
    {
        public U ForeignKey { get; set; } = Activator.CreateInstance<U>();
    }
}
