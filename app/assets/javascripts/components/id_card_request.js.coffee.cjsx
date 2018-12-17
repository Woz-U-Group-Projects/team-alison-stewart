@IdCardRequest = React.createClass
  displayName: "IdCardRequest"

  propTypes:
    idCardTemplate: React.PropTypes.object.isRequired
    idCardRequest:  React.PropTypes.object.isRequired

  getInitialState: ->
    templateWidth:  null
    templateHeight: null
    nodes:          @props.idCardRequest.included.filter (item) -> item.attributes.type is 'Nodes::Text' || item.attributes.type is 'Nodes::Photo'

  componentDidMount: ->
    @loadTemplateImage()

  componentDidUpdate: (prevProps, prevState) ->
    return unless prevState.templateWidth is null and @state.templateWidth isnt null

    for node, index in @state.nodes
      continue unless node.attributes.type is 'Nodes::Photo'

      initializeCropper(index)

  loadTemplateImage: ->
    template = new Image()

    template.onload = (event) =>
      @setState
        templateWidth:  event.currentTarget.width
        templateHeight: event.currentTarget.height

    template.src = @props.idCardTemplate.data.attributes.base_photo_url

  renderPrerenderText: ->
    for node, index in @state.nodes
      continue unless node.attributes.type is 'Nodes::Text'

      value = ''

      for phrase, p_index in node.relationships.phrases.data
        text    = $('#id_card_request_nodes_attributes_' + index + '_phrases_attributes_' + p_index + '_text').val()
        prefix  = $('#id_card_request_nodes_attributes_' + index + '_phrases_attributes_' + p_index + '_prefix').val()
        suffix  = $('#id_card_request_nodes_attributes_' + index + '_phrases_attributes_' + p_index + '_suffix').val()

        if text
          value += prefix + text + suffix

      continue unless value

      style =
        top:        node.attributes.y + 'px'
        left:       node.attributes.x + 'px'
        width:      node.attributes.width + 'px'
        height:     node.attributes.height + 'px'
        fontSize:   $("#id_card_request_nodes_attributes_#{index}_point_size").val() + 'px'
        fontFamily: node.attributes.font_family
        color:      node.attributes.color
        textAlign:  node.attributes.alignment

      if $("#id_card_request_nodes_attributes_#{index}_uppercase").val() is 'true'
        style.textTransform = 'uppercase'

      <span key={ "text-render-#{index}" } className="id-card-request__pre-render-text" style={ style }>
        { value }
      </span>

  renderPrerenderPhoto: ->
    for node, index in @state.nodes
      continue unless node.attributes.type is 'Nodes::Photo'

      style =
        top:              node.attributes.y + 'px'
        left:             node.attributes.x + 'px'
        width:            node.attributes.width + 'px'
        height:           node.attributes.height + 'px'

      if node.attributes.mask_url || node.attributes.remote_mask_url
        style.WebkitMaskImage = "url(#{node.attributes.mask_url || node.attributes.remote_mask_url})"
        style.WebkitMaskSize  = "100% 100%"
        style.OMaskImage      = "url(#{node.attributes.mask_url || node.attributes.remote_mask_url})"
        style.MozMaskImage    = "url(#{node.attributes.mask_url || node.attributes.remote_mask_url})"
        style.maskImage       = "url(#{node.attributes.mask_url || node.attributes.remote_mask_url})"

      <div key={ "photo-render-#{index}" } id={ "photo-preview-#{index}" } className="id-card-request__pre-render-photo-container" style={ style }>
      </div>

  renderPreview: ->
    <div>
      <h3 className="headline headline--sub">Preview</h3>

      {
        if @state.templateWidth
          <div className="id-card-request__pre-render">
            <img className="id-card-request__pre-render-image" src={ @props.idCardTemplate.data.attributes.base_photo_url } />

            { @renderPrerenderText() }
            { @renderPrerenderPhoto() }
          </div>
        else
          <div className="loading" />
      }
    </div>

  render: ->
    <section>
      { @renderPreview() }
    </section>
