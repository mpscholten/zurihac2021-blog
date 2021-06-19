module Web.Controller.Posts where

import Web.Controller.Prelude
import Web.View.Posts.Index
import Web.View.Posts.New
import Web.View.Posts.Edit
import Web.View.Posts.Show
import qualified Text.MMark as MMark

instance Controller PostsController where
    action PostsAction = do
        posts <- query @Post
            |> orderByDesc #createdAt
            |> fetch
        render IndexView { .. }

    action NewPostAction = do
        let post = newRecord
        render NewView { .. }

    action ShowPostAction { postId } = do
        post <- fetch postId
            >>= pure . modify  #comments (orderByDesc #createdAt)
            >>= fetchRelated #comments
        render ShowView { .. }

    action EditPostAction { postId } = do
        post <- fetch postId
        render EditView { .. }

    action UpdatePostAction { postId } = do
        post <- fetch postId
        post
            |> buildPost
            |> ifValid \case
                Left post -> render EditView { .. }
                Right post -> do
                    post <- post |> updateRecord
                    setSuccessMessage "Post updated"
                    redirectTo EditPostAction { .. }

    action CreatePostAction = do
        let post = newRecord @Post
        post
            |> buildPost
            |> validateField #title nonEmpty
            |> validateField #body nonEmpty
            |> validateField #body isMarkdown
            |> ifValid \case
                Left post -> render NewView { .. } 
                Right post -> do
                    post <- post |> createRecord
                    setSuccessMessage "Post created"
                    redirectTo PostsAction

    action DeletePostAction { postId } = do
        post <- fetch postId
        deleteRecord post
        setSuccessMessage "Post deleted"
        redirectTo PostsAction

buildPost :: (?context::ControllerContext, ParamReader fieldType1, ParamReader fieldType2, SetField "body" t2 fieldType2, SetField "meta" t2 MetaBag, SetField "title" t2 fieldType1, HasField "meta" t2 MetaBag, HasField "title" t2 value, IsEmpty value) => t2 -> t2
buildPost post = post
    |> fill @["title","body"]


isMarkdown :: Text -> ValidatorResult 
isMarkdown text = 
    case text |> MMark.parse "" of
        Left error -> Failure "Please check your markdown for errors"
        Right markdown -> Success