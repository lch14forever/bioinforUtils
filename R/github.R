##' @title gh_response
##'
##' @param issue github issue number
##' @param comment text message to comment on issue
##' @param owner github user name
##' @param repo github repository
##' @param figure figure path in the working repository (default: `issue_figures/{issue}.png`)
##' @param branch github branch to commit (default: "main")
##' @description submit a comment with an attached figure
##' @importFrom glue glue
##' @importFrom gh gh
##' @export
##' @author Chenhao Li
gh_response <- function(issue, comment, owner, repo, figure=paste0("issue_figures/", issue, ".png"),
                        branch = "main"){
  message_body_text <- comment

  message_body_text <- glue::glue("{comment}\n![](../blob/{branch}/{figure}?raw=true)",
                                  comment = message_body_text,
                                  owner = owner,
                                  branch = branch,
                                  repo=repo,
                                  fig_path = fig_path,
                                  figure = figure
  )

  #message_body_text
  gh::gh("POST /repos/{owner}/{repo}/issues/{issue_number}/comments", owner=owner, repo=repo, issue_number=issue,
         body=message_body_text)
}
