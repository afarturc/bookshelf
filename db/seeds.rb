# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Book.find_or_create_by(
  title: "A Economia numa Lição",
  description: "Da autoria de um dos maiores divulgadores da Escola Austriaca, Economia numa Lic?o e um texto conciso e esclarecedor que visa desmontar algumas falacias economicas que adquiriram quase estatuto de dogma, t?o predominantes se tornaram. Ao por a tonica em soluc?es que n?o passem pela intervenc?o estatal, numa posic?o contra os defices e que valoriza os mercados livres e a liberdade do individuo, este texto de Hazlitt e hoje t?o relevante como na altura em que foi escrito, em 1946.",
  cover_url: "https://cdn.kobo.com/book-images/16cc247b-a1cc-4d35-8a48-92321a43b5c9/353/569/90/False/a-economia-numa-licao.jpg"
)

Book.find_or_create_by(
  title: "Lockwood & Co: The Creeping Shadow",
  description: "Lucy has left Lockwood & Co. A freelance operative, she is hiring herself out to other agencies - agencies that might value her ever-improving skills. But now Lockwood needs her help. Penelope Fittes, leader of the well-renowned Fittes Agency wants Lockwood & Co. - and only them - to locate and remove the 'Source' for the legendary Brixton Cannibal. It's a tough assignment. Made worse by the tensions between Lucy and the other agents - even the skull is treating her like a jilted lover! What will it take to reunite the team? Black marketeers, an informant ghost, a Spirit Cape that transports the wearer, and mysteries involving their closest rivals may just do the trick. But not all is at it seems. And it's not long before a shocking revelation rocks Lockwood & Co. to its very core . . .",
  cover_url: "https://cdn.kobo.com/book-images/74925123-c8ce-4bc1-a8ed-804b47bc736f/353/569/90/False/lockwood-co-the-creeping-shadow.jpg"
)

Book.find_or_create_by(
  title: "The Beginning After The End - Early Years",
  description: "King Grey has unrivaled strength, wealth, and prestige in a world governed by martial ability. However, solitude lingers closely behind those with great power. Beneath the glamorous exterior of a powerful king lurks the shell of a man, devoid of purpose and will. Reincarnated into a new world filled with magic and monsters, the king has a second chance to relive his life. Correcting the mistakes of his past will not be his only challenge, however. Underneath the peace and prosperity of the new world is an undercurrent threatening to destroy everything he has worked for, questioning his role and reason for being born again.",
  cover_url: "https://cdn.kobo.com/book-images/39652de0-fc64-43f1-9a52-598cf68347a0/353/569/90/False/early-years-3.jpg"
)
