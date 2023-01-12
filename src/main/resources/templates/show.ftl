<#-- @ftlvariable name="article" type="ru.project.zaicev.models.View" -->
<#import "_layout.ftl" as layout />
<@layout.header>
    <div>
        <h3>
            ${article.title}
        </h3>
        <p>
            ${article.body}
        </p>
        <hr>
        <p>
            <a href="/articles/${article.id}/edit">Edit article</a>
        </p>
    </div>
</@layout.header>