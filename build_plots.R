require(ggplot2)
if (FALSE) {
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

thisplot <- qplot(book.age.years,Average.Rating,data=read_goodreads,main = "Average Rating Read After Goodreads By Book Age")
print(thisplot)

thisplot <- qplot(book.age.years,My.Rating,data=read_goodreads,main = "My Rating Read After Goodreads By Book Age")
print(thisplot)

#thisplot <- ggplot(read_goodreads,aes(Original.Publication.Year,My.Rating+Average.Rating)) + geom_count()

thisplot <- ggplot(read_goodreads,aes(Original.Publication.Year,My.Rating))
thisplot <- thisplot + labs(x="Pub Year", y="Rating")
thisplot <- thisplot + geom_count(aes(color="red"))
thisplot <- thisplot + geom_point(aes(Original.Publication.Year,Average.Rating,color="blue"))
thisplot <- thisplot + scale_colour_discrete(name  ="Rating",
                          breaks=c("blue", "red"),
                          labels=c("Avg", "Mine"))
thisplot <- thisplot + ggtitle("Rating vs Pub Year")

print(thisplot)

thisplot <- ggplot(read_goodreads,aes(reorder(book.age.years, Original.Publication.Year),My.Rating))
thisplot <- thisplot + labs(x="Pub Year", y="Rating")
thisplot <- thisplot + geom_count(aes(color="red"))
#thisplot <- thisplot + geom_point(aes(reorder(book.age.years, Original.Publication.Year),Average.Rating,color="blue"))
#thisplot <- thisplot + scale_colour_discrete(name  ="Rating",
#                                             breaks=c("blue", "red"),
#                                             labels=c("Avg", "Mine"))
#thisplot <- thisplot + ggtitle("Rating vs Book Age")

print(thisplot)


thisplot <- ggplot(read_books,aes(Original.Publication.Year,My.Rating, group=before_after_gr,color="red"))
thisplot <- thisplot + labs(x="Pub Year", y="Rating")
thisplot <- thisplot + geom_count()
thisplot <- thisplot + geom_point(aes(Original.Publication.Year,Average.Rating, group=before_after_gr,color="blue"))
thisplot <- thisplot + scale_colour_discrete(name  ="Rating",
                                             breaks=c("blue", "red"),
                                             labels=c("Avg", "Mine"))
thisplot <- thisplot + ggtitle("Rating vs Pub Year2")
thisplot <- thisplot + facet_grid(before_after_gr ~ ., scales = "free", space = "free")

print(thisplot)


thisplot <- ggplot(read_books,aes(book.age.years,My.Rating, group=before_after_gr,color="red"))
thisplot <- thisplot + labs(x="Book Age", y="Rating")
thisplot <- thisplot + geom_count()
thisplot <- thisplot + geom_point(aes(book.age.years,Average.Rating, group=before_after_gr,color="blue"))
thisplot <- thisplot + scale_colour_discrete(name  ="Rating",
                                             breaks=c("blue", "red"),
                                             labels=c("Avg", "Mine"))
thisplot <- thisplot + ggtitle("Rating vs book.age.years2")
thisplot <- thisplot + facet_grid(before_after_gr ~ ., scales = "free", space = "free")

print(thisplot)

thisplot <- ggplot(read_books,aes(book.age.years,rating_error, group=before_after_gr,color="red"))
thisplot <- thisplot + labs(x="Book Age", y="Rating Error")
thisplot <- thisplot + geom_count()
thisplot <- thisplot + geom_abline()
thisplot <- thisplot + geom_vline(xintercept=16)
thisplot <- thisplot + geom_vline(xintercept=116)
thisplot <- thisplot + ggtitle("Rating Error vs book.age.years")
thisplot <- thisplot + facet_grid(before_after_gr ~ ., scales = "free", space = "free")

print(thisplot)

thisplot <- ggplot(data_raw_selected,aes(Original.Publication.Year,Average.Rating, group=Series.Num))
thisplot <- thisplot + labs(x="Pub Year", y="Rating")
thisplot <- thisplot + geom_count()
thisplot <- thisplot + geom_abline()
thisplot <- thisplot + ggtitle("Rating vs Pub Year by Series#")
thisplot <- thisplot + facet_grid(Series.Num ~ ., scales = "free", space = "free")

print(thisplot)
}


thisplot <- ggplot(read_books,aes(Decade.pub,rating_error, group=Binding, colour = Binding))
thisplot <- thisplot + labs(x="Pub Decade", y="Rating Error")
thisplot <- thisplot + geom_count()
thisplot <- thisplot + ggtitle("Rating vs Pub Decade by Binding")
#thisplot <- thisplot + facet_grid(Binding ~ ., scales = "free", space = "free")

print(thisplot)


thisplot <- ggplot(read_books,aes(Decade.pub,My.Rating))
thisplot <- thisplot + labs(x="Pub Decade", y="Rating")
thisplot <- thisplot + geom_count(aes(color="red"))
thisplot <- thisplot + geom_point(aes(Decade.pub,Average.Rating,color="blue"))
thisplot <- thisplot + scale_colour_discrete(name  ="Rating",
                                             breaks=c("blue", "red"),
                                             labels=c("Avg", "Mine"))
thisplot <- thisplot + facet_wrap(~ Binding, nrow=2, ncol=2, scales = "free")
thisplot <- thisplot + ggtitle("Rating vs Pub Decade")

print(thisplot)


thisplot <- ggplot(read_books,aes(Decade.pub,My.Rating,color="red"))
thisplot <- thisplot + labs(x="Pub Decade", y="Rating")
thisplot <- thisplot + geom_line()
thisplot <- thisplot + geom_line(aes(Decade.pub,Average.Rating,color="blue"))
thisplot <- thisplot + scale_colour_discrete(name  ="Rating",
                                             breaks=c("blue", "red"),
                                             labels=c("Avg", "Mine"))
#thisplot <- thisplot + facet_wrap(~ Binding, nrow=2, ncol=2, scales = "free")
thisplot <- thisplot + ggtitle("Rating vs Pub Decade")

print(thisplot)