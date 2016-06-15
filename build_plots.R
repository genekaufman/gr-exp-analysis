require(ggplot2)
thisplot <- qplot(Average.Rating,My.Rating,data=read_books,main = "All Read Books")
print(thisplot)

thisplot <- qplot(Average.Rating,My.Rating,data=read_goodreads,main = "Read After Goodreads")
print(thisplot)

thisplot <- qplot(Average.Rating,My.Rating,data=read_before_gr,main = "Read Before Goodreads")
print(thisplot)

thisplot <- qplot(Original.Publication.Year,Average.Rating,data=read_goodreads,main = "Avg Rating Read After Goodreads By Year")
print(thisplot)

thisplot <- qplot(Original.Publication.Year,Average.Rating,data=read_before_gr,main = "Avg Rating Read Before Goodreads By Year")
print(thisplot)


thisplot <- qplot(Original.Publication.Year,My.Rating,data=read_goodreads,main = "My Rating Read After Goodreads By Year")
print(thisplot)

thisplot <- qplot(Original.Publication.Year,My.Rating,data=read_before_gr,main = "My Rating Read Before Goodreads By Year")
print(thisplot)