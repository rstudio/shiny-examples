
library(testthat)
testServer({
  describe("server", {
    # Initialize
    session$setInputs(selection="summer", freq=15, max=100, update=0)

    it("initializes properly", {
      # Check overall length and spot check the first couple entries
      expect_length(terms(), 2718)
      expect_equal(terms()[1], c("love"=99))
      expect_equal(terms()[2], c("demetrius"=98))
    })

    # Stash the plot source as it appeared for summer
    summer_plot <- output$plot$src

    it("doesn't change terms without clicking update", {
      # Change selection without clicking
      summer_terms <- terms()
      session$setInputs(selection="merchant")

      expect_equal(terms(), summer_terms)
      expect_equal(output$plot$src, summer_plot)
    })

    it("updates when update is clicked", {
      # Simulate update click
      session$setInputs(update=1)
      expect_length(terms(), 3262)
      expect_false(output$plot$src == summer_plot)
    })

    it ("updates the plot when freq or max are updated", {
      # Update freq
      p <- output$plot$src
      session$setInputs(freq=20)
      expect_false(p == output$plot$src)

      # Update max
      p <- output$plot$src
      session$setInputs(max=10)
      expect_false(p == output$plot$src)
    })
  })
})
