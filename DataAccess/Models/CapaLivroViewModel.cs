using Microsoft.AspNetCore.Http;
using System;

namespace DataAccess.Models
{
    public class CapaLivroViewModel : PadraoForeignViewModel<LivroViewModel>
    {
        public LivroViewModel Livro
        {
            get => ForeignKey;
            set => ForeignKey = value;
        }

        /// <summary>
        /// Imagem recebida do form pelo controller
        /// </summary>
        public IFormFile Imagem { get; set; }

        /// <summary>
        /// Imagem em bytes pronta para ser salva
        /// </summary>
        public byte[] ImagemEmByte { get; set; }

        /// <summary>
        /// Imagem usada para ser enviada ao form no formato para ser exibida
        /// </summary>
        public string ImagemEmBase64
        {
            get
            {
                if (ImagemEmByte != null)
                    return Convert.ToBase64String(ImagemEmByte);
                else
                    return string.Empty;
            }
        }

    }
}
