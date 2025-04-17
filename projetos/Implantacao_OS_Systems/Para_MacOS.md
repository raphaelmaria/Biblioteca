Quais as ferramentas que permitem fazer instalacao do MacOS via rede, usando um servidor local com uma imagem customizada, que sejam open-source 
Ao instalar o macOS usando um servidor local com uma imagem personalizada, você pode utilizar várias ferramentas open-source. Algumas dessas ferramentas incluem o NetInstall, o Imagr e o BSDPy.

NetInstall: O NetInstall é uma ferramenta nativa da Apple que permite a instalação do sistema operacional macOS via rede. Apesar de ser incorporado ao macOS Server, ele é considerado obsoleto desde a versão macOS Mojave e não é desenvolvido ativamente. Entretanto, ainda pode ser usado em versões mais antigas do macOS.

Imagr: Imagr (https://github.com/grahamgilbert/imagr) é uma solução open-source para implementação de imagens macOS. Ao contrário do NetInstall, Imagr oferece mais flexibilidade na customização e automação do processo. Para usar esta ferramenta, é necessário configurar um servidor WebDAV ou HTTP(S) para hospedar os arquivos necessários, como a imagem customizada.

BSDPy: BSDPy (https://github.com/bruienne/bsdpy) é um servidor de protocolo de inicialização de serviço da Apple (BSDP) escrito em Python. Ele foi projetado para funcionar independentemente do macOS, permitindo que você use diferentes sistemas operacionais como servidor. Combinando o BSDPy com um servidor HTTP(S) e a configuração adequada, é possível criar uma solução open-source para instalar o macOS através de uma imagem personalizada.

No entanto, vale salientar que essas ferramentas podem ter limitações no suporte às versões mais recentes do macOS e podem exigir conhecimento técnico para configurá-las corretamente. A utilização destas soluções requer uma compreensão profunda dos protocolos e serviços de rede, assim como habilidades em programação e automação.

Além disso, é importante lembrar que a distribuição e utilização de imagens personalizadas do macOS sem o consentimento da Apple podem violar os termos de seus acordos de licença. Portanto, sempre verifique as restrições legais ao adotar essas ferramentas e soluções open-source.